module Impl.ByteString
  ( Builder
  , Target
  , Settings
  , ascii
  , paddedWord16
  , run
  , shortText
  , B.word8
  ) where

import Data.ByteString.Builder (Builder)
import Data.ByteString.Builder.Extra (AllocationStrategy)
import Data.Word (Word16)
import Control.DeepSeq (force)
import Data.Text.Short (ShortText)
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Builder.Extra as E
import qualified Data.ByteString.Builder as B
import qualified Data.Text.Short as TS

type Target = L.ByteString
type Settings = AllocationStrategy

ascii :: Char -> Builder
ascii = B.char7

paddedWord16 :: Word16 -> Builder
{-# inline paddedWord16 #-}
paddedWord16 = B.word16HexFixed

shortText :: ShortText -> Builder 
{-# inline shortText #-}
shortText = B.shortByteString . TS.toShortByteString

run :: Settings -> Builder -> Target
run s bldr = force (E.toLazyByteStringWith s L.empty bldr)
