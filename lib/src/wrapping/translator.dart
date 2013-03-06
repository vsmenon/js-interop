// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of js.wrapping;

class Translator<E> {
  final Mapper<dynamic, E> fromJs;
  final Mapper<E, dynamic> toJs;

  Translator(this.fromJs, this.toJs);
}

class TranslatorForProxy<E extends Serializable<Proxy>>
    implements Translator<E> {
  Mapper<dynamic, E> _fromJs;
  Mapper<E, dynamic> _toJs;

  TranslatorForProxy(final Mapper<Proxy, E> fromJs, {mapOnlyNotNull : true}) {
    this._fromJs = (Proxy p) => mapOnlyNotNull ? mapNotNull(p, fromJs) :
      fromJs(p);
    this._toJs = (E s) => s != null ? s.toJs() : null;
  }

  Mapper<dynamic, E> get fromJs => this._fromJs;
  Mapper<E, dynamic> get toJs => this._toJs;
}