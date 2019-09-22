{-# language BangPatterns #-}
module Data.Tree.Word16
  ( Word16Tree(..)
  , ex2000
  , ex9000
  ) where

import Data.ByteArray.Builder as B
import Data.Word (Word16)
import Data.Primitive (ByteArray)
import qualified Data.Bytes as Bytes

data Word16Tree
  = Branch !Word16Tree !Word16Tree
  | Leaf {-# UNPACK #-} !Word16

ex2000 :: Word16Tree
{-# noinline ex2000 #-}
ex2000 = balanced 0 2000

ex9000 :: Word16Tree
{-# noinline ex9000 #-}
ex9000 = balanced 0 9000

balanced :: Word16 -> Word16 -> Word16Tree
balanced !off !n
  | n == 0 = Leaf off
  | n == 1 = Leaf (off + 1)
  | otherwise = let x = div n 2 in
      Branch (balanced off x) (balanced (off + x) (n - x))

