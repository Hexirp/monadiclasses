monadiclasses
====

__My English level ability isn't native level, so I write this commentary in Japanese. However, this package is simple and therefore you can understand it.__

<!--
    私の英語能力はネイティブレベルではないため、私は日本語でこの解説を書きます。しかし、このパッケージは単純なので、あなたはそれを理解できます。
-->

これはMonadに関係する全ての型クラスを実装する事を目的とし、型クラスに関する辞書としても機能させたいと思っています。このパッケージは欲望から生まれました。


## Description

これらはパッケージの型クラスの解説です。

### Functor

このパッケージはFunctorに近しい関係にある型クラスを含みます。

#### Invariant

これはFunctorよりも制約が弱い型クラスです。名前は「不変」を意味します。注意として、`fmap`や`contra`と対応するのは`xmap`ではなく`invar`です。`invar`だけでは制約が弱すぎて`const id`とすることで任意の型に対して実装することが可能であり、それはこの型クラスの意味に反するため`xmap`が含まれています。

```haskell
    xmap id id               === id
    xmap (f1 . f2) (g1 . g2) === xmap f1 g2 . xmap f2 g1
```

下はインスタンスとなる型の例です。これがFunctorとContravariantではないことに注意してください。

```haskell
    data Sample a = Ex (a -> a)

    instance Invariant Sample where
        xmap f g (Ex x) = Ex $ g . x . f
```

#### Functor

皆さんはもう知っていると思いますので、解説しません。

#### Contravariant

```haskell
    contra id      === id
    contra (f . g) === contra g . contra f
```

これはFunctorと対となる型クラスです。名前は「反変」を意味します。これになることが出来る型は、関数型が絡んでいるもののみです。下はインスタンスとなる型の例です。

```haskell
    data Test a = Test (a -> Bool)
    instance Contravariant Test where
        contra f (Test x) = Test $ x . f
```

#### Nonvariant

これはFunctorとContravariantをまとめた型クラスです。`f a`という型を持つ値を作る時、実際の値には`a`の情報が含まれていません。下はインスタンスとなる型の例です。

```haskell
    data Const a b = Const a
    instanse ...
        fmap _ = id
        contra _ = id
```

### Wrapper, Conquer

これらは`return`やそのバリエーションの大本である型が含まれます。

#### Wrapper, Unwrapper, Conquer, Unquer

`wrap`は`point`や`pure`や`return`などとも書かれ、`unwrap`は`copoint`や`extract`などとも書かれます。それら全ての関数は同一の物です。

Conquerの名前は[Hackage: contravariant-1.4][1]に基づいています。Unquerはそれにあたる名前が分からなかったので、unとconquerを合わせて作成しました。

ちなみに、これらの型クラスに含まれる関数群はそのままでは対称性が見えませんが、冗長な型を持つ版では対称性が現れます。

```haskell
    wrap'    :: (() -> a) -> f a
    unwrap'  :: f a -> (() -> a)
    conquer' :: (a -> ()) -> f a
    unquer'  :: f a -> (a -> ())
```

上の関数群の冗長な部分を取り除くために、以下の変換を使用しました。

```haskell
    () -> a === a
    a -> () === ()
```

Unquerは意味がありませんが、対称性の関係から実装しています。

####　Identity, Contity

WrapperとUnwrapperを合わせたのがIdentity、ConquerとUnquerを合わせたのがContityです。Contityはそれにあたる名前が分からなかったので、conquerとidentityを合わせて作成しました。

### Monad

このパッケージはMonadに近い位置にある型クラスを含みます。これらの大きな特徴はApplicativeとMonadから「関数の適用」を実装する部分が分離されていることです。

### Comonad

このパッケージはComonadに近い位置にある型クラスを含みます。Monadモジュールと同様の分割をしました。

### Divide

このパッケージはDivideに近い位置にある型クラスを含みます。`divide :: (And and) => (and a b -> c) -> (c -> and a b)`はApplyの`cift2`と対です。この名前は[Hackage: contravariant-1.4][1]に基づいており、第二引数が二つの値に分けられて返される様子から名付けられたそうです。また、この型クラス群は[scalaz][2]にも基づいています。また、`conquer`の名前は分割統治法(Divide-and-Conquer method)に由来しているそうです。

### Codivide

このパッケージはCodivideに近い位置にある型クラスを含みます。`codivide`はCoapplyの`cict2`と対です。

## Version

更新履歴をここに記載します。

### 1.0.0.0

このバージョンは最初にコンパイルが成功したバージョンです。

* Add - ライセンス(BSD-3)ファイル
* Add - READMEの型クラスの解説
* Add - ソースコード
    * Add - Functor、Wrapper、Conquer
    * Add - Monad、Comonad、Divide、Codivideに関する型クラス
    * Add - 汎用の関数群
    * Add - `()`、`(,)`、`Either`を抽象化した型クラス
    * Add - テストコードのひな形

### 0.0.0.0

このバージョンはパッケージがまだ存在していないバージョンです。


[1]:https://hackage.haskell.org/package/contravariant-1.4
[2]:https://github.com/scalaz/scalaz