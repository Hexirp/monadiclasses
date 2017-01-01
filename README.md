monadiclasses
====

これはMonadに関係する全ての型クラスのメモです。

Description
----

これらはパッケージの型クラスの内容のメモです。
### Functor

このパッケージはFunctorに近しい関係にある型クラスを含みます。

#### Invariant

これはFunctorよりも制約が弱い型クラスです。名前は「不変」を意味します。注意として、`fmap`や`contra`と対応するのは`xmap`ではなく`invar`です。`invar`だけでは制約が弱すぎて`const id`とすることで任意の型に対して実装することが可能であり、それはこの型クラスの意味に反するため`xmap`が含まれています。

invariant則:
```haskell
    xmap id id               === id
    xmap (f1 . f2) (g1 . g2) === xmap f1 g2 . xmap f2 g1
```

下はインスタンスとなる型の例です。これがFunctorとContravariantではないことに注意してください。

```haskell
    data Endo a = Endo (a -> a)

    instance Invariant Sample where
        xmap f g (Endo x) = Endo $ g . x . f
```

#### Functor

皆さんはもう知っていると思いますが、Functorは中身の値、または生み出す値に適用する事が出来る型の抽象化です。法則はInvariantがこのパッケージに含まれることにより、次のように単純になります。

functor則:
```haskell
    fmap f === xmap f undefined
```

#### Contravariant

contravarinat則:
```haskell
    contra id      === id
    contra (f . g) === contra g . contra f
```

これはFunctorと対となる型クラスです。名前は「反変」を意味します。下はインスタンスとなる型の例です。

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

Unquerは全ての型がなることが出来るため、意味がありませんが、対称性の関係から実装しています。

#### Identity, Contity

WrapperとUnwrapperを合わせたのがIdentity、ConquerとUnquerを合わせたのがContityです。Contityはそれにあたる名前が分からなかったので、conquerとidentityを合わせて作成しました。ContityはConquerと同じですが、対称性の関係から実装しています。

### Monad

このパッケージはMonadに近い位置にある型クラスを含みます。これらの大きな特徴はApplicativeとMonadから「関数の適用」を実装する部分が分離されていることです。

Pointed則:
```haskell
    fmap f . wrap === wrap . f
```

### Comonad

このパッケージはComonadに近い位置にある型クラスを含みます。Monadモジュールと同様の分割が適用されています。

### Divide

このパッケージはDivideに近い位置にある型クラスを含みます。`divide :: (And and) => (and a b -> c) -> (c -> and a b)`はApplyの`cift2`と対です。この名前は[Hackage: contravariant-1.4][1]に基づいており、第二引数が二つの値に分けられて返される様子に由来しており、`conquer`の名前は分割統治法(Divide-and-Conquer method)に由来しているそうです。また、この型クラス群は[scalaz][2]にも基づいています。

Divisible則(contravariant-1.4から引用):
```haskell
    delta a = (a, a)
    divide delta m conquer = m
    divide delta conquer m = m
    divide delta (divide delta m n) o = divide delta m (divide delta n o)
```

### Codivide

このパッケージはCodivideに近い位置にある型クラスを含みます。`codivide`はCoapplyの`cict2`と対です。UntrapointedはContravariantと同じですが、対称性の関係から実装しています。

### Minimal

これらのクラスは最小のコード量での型クラス定義を提供します。たとえば、Minimalを使用しないと、Monadを使用するために__7個__もの型クラスとたくさんの関数を実装する必要があります。しかし、使えば2個、または3個の関数を実装するだけで済みます。

[1]:https://hackage.haskell.org/package/contravariant-1.4
[2]:https://github.com/scalaz/scalaz
