{-# language BangPatterns #-}
module Data.Tree.ShortText
  ( ShortTextTree(..)
  , ex1000
  , ex9000
  ) where

import Data.ByteArray.Builder as B
import Data.Text.Short (ShortText)
import Data.Primitive (ByteArray)
import qualified Data.Text.Short as TS
import qualified Data.Bytes as Bytes

data ShortTextTree
  = Branch !ShortTextTree !ShortTextTree
  | Leaf {-# UNPACK #-} !ShortText

ex1000 :: ShortTextTree
{-# noinline ex1000 #-}
ex1000 = balanced 0 1000

ex9000 :: ShortTextTree
{-# noinline ex9000 #-}
ex9000 = balanced 0 9000

balanced :: Word -> Word -> ShortTextTree
balanced !off !n
  | n == 0 = Leaf (TS.pack (show off))
  | n == 1 = Leaf (TS.pack (show (off + 1)))
  | otherwise = let x = div n 2 in
      Branch (balanced off x) (balanced (off + x) (n - x))


