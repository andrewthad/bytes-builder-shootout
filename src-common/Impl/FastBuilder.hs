module Impl.FastBuilder
  ( Builder
  , Target
  , Settings
  , ascii
  , paddedWord16
  , run
  , shortText
  , B.word8
  ) where

import Data.ByteString.FastBuilder (Builder)
import Data.Word (Word16)
import Control.DeepSeq (force)
import Data.Text.Short (ShortText)
import qualified Data.ByteString.Short as BS
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.FastBuilder as B
import qualified Data.Text.Short as TS

type Target = L.ByteString
type Settings = (Int,Int)

ascii :: Char -> Builder
{-# inline ascii #-}
ascii = B.char7

paddedWord16 :: Word16 -> Builder
{-# inline paddedWord16 #-}
paddedWord16 = B.word16HexFixed

run :: Settings -> Builder -> Target
{-# inline run #-}
run (a,b) bldr = force (B.toLazyByteStringWith a b bldr)

shortText :: ShortText -> Builder 
{-# inline shortText #-}
shortText = B.byteString . BS.fromShort . TS.toShortByteString

