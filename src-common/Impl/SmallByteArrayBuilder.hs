module Impl.SmallByteArrayBuilder
  ( Builder
  , Target
  , Settings
  , B.ascii
  , shortText
  , paddedWord16
  , B.run
  , B.word8
  ) where

import Data.Word (Word16)
import Data.ByteArray.Builder (Builder)
import Data.Primitive (ByteArray)
import Data.Text.Short (ShortText)
import Data.Bytes.Chunks (Chunks)
import qualified Data.ByteArray.Builder as B

type Target = Chunks
type Settings = Int

shortText :: ShortText -> Builder
{-# inline shortText #-}
shortText = B.shortTextUtf8

paddedWord16 :: Word16 -> Builder
{-# inline paddedWord16 #-}
paddedWord16 = B.word16PaddedUpperHex
