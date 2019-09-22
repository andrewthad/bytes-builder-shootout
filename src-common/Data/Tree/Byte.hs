{-# language BangPatterns #-}
module Data.Tree.Byte
  ( ByteTree(..)
  , ex2000
  , ex9000
  ) where

import Data.ByteArray.Builder as B
import Data.Word (Word8)
import Data.Primitive (ByteArray)
import qualified Data.Bytes as Bytes

data ByteTree
  = Branch !ByteTree !ByteTree
  | Leaf {-# UNPACK #-} !Word8

ex2000 :: ByteTree
{-# noinline ex2000 #-}
ex2000 = balanced 0 2000

ex9000 :: ByteTree
{-# noinline ex9000 #-}
ex9000 = balanced 0 9000

balanced :: Word -> Word -> ByteTree
balanced !off !n
  | n == 0 = Leaf (fromIntegral off)
  | n == 1 = Leaf (fromIntegral (off + 1))
  | otherwise = let x = div n 2 in
      Branch (balanced off x) (balanced (off + x) (n - x))


