{-# LANGUAGE RankNTypes #-}
module Impl.Mason
  ( B.Builder
  , Target
  , Settings
  , ascii
  , paddedWord16
  , run
  , shortText
  , word8
  ) where

import Data.Word (Word16, Word8)
import Control.DeepSeq (force)
import Data.Text.Short (ShortText)
import qualified Data.ByteString.Lazy as BL
import qualified Mason.Builder.Compat as B
import qualified Data.Text.Short as TS

type Target = BL.ByteString
type Settings = ()

ascii :: Char -> B.Builder
ascii = B.char7
{-# INLINE ascii #-}

word8 :: Word8 -> B.Builder
word8 = B.word8
{-# INLINE word8 #-}

paddedWord16 :: Word16 -> B.Builder
{-# inline paddedWord16 #-}
paddedWord16 = B.word16HexFixed

shortText :: ShortText -> B.Builder
{-# inline shortText #-}
shortText = B.shortByteString . TS.toShortByteString

run :: Settings -> B.Builder -> Target
run _ bldr = force (B.toLazyByteString bldr)
{-# INLINE run #-}
