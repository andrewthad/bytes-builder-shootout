{-# language BangPatterns #-}

module Encode
  ( treeToHex
  , shortTextTree
  , byteTree
  ) where

import Builder (Builder,Target,Settings)
import Data.Tree.Word16 (Word16Tree(Leaf,Branch))
import Data.Tree.ShortText (ShortTextTree)
import Data.Tree.Byte (ByteTree)
import qualified Data.Tree.ShortText as STT
import qualified Data.Tree.Byte as BT
import qualified Builder as B

byteTree :: Settings -> ByteTree -> Target
byteTree !s t = B.run s (byteTreeBuilder t)

byteTreeBuilder :: ByteTree -> Builder
byteTreeBuilder (BT.Leaf w) = B.word8 w
byteTreeBuilder (BT.Branch a b) =
  B.ascii '('
  <>
  byteTreeBuilder a
  <>
  B.ascii ','
  <>
  byteTreeBuilder b
  <>
  B.ascii ')'

treeToHex :: Settings -> Word16Tree -> Target
treeToHex !s t = B.run s (treeToHexBuilder t)

treeToHexBuilder :: Word16Tree -> Builder
treeToHexBuilder (Leaf w) = B.paddedWord16 w
treeToHexBuilder (Branch a b) =
  B.ascii '('
  <>
  treeToHexBuilder a
  <>
  B.ascii ','
  <>
  treeToHexBuilder b
  <>
  B.ascii ')'

shortTextTree :: Settings -> ShortTextTree -> Target
shortTextTree !s t = B.run s (shortTextTreeStep t)

shortTextTreeStep :: ShortTextTree -> Builder
shortTextTreeStep (STT.Leaf w) = B.shortText w
shortTextTreeStep (STT.Branch a b) =
  B.ascii '('
  <>
  shortTextTreeStep a
  <>
  B.ascii ','
  <>
  shortTextTreeStep b
  <>
  B.ascii ')'


