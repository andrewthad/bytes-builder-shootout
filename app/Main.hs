{-# language LambdaCase #-}
{-# language OverloadedStrings #-}

import Data.Primitive (ByteArray)
import Gauge (bgroup,bench,whnf)
import Gauge.Main (defaultMain)
import Data.Tree.Word16 (Word16Tree)

import qualified Data.ByteArray.Builder as B
import qualified Data.ByteString.Builder.Extra as E

import qualified Encode.SmallByteArrayBuilder as SmallByteArrayBuilder
import qualified Encode.ByteString as ByteString
import qualified Encode.FastBuilder as FastBuilder
import qualified Encode.Mason as Mason

import qualified Data.Tree.Word16 as Word16Tree
import qualified Data.Tree.ShortText as ShortTextTree
import qualified Data.Tree.Byte as ByteTree

main :: IO ()
main = defaultMain
  [ bgroup "treeToHex-2000"
    [ bench "small-bytearray-builder" $ whnf
        (\x -> SmallByteArrayBuilder.treeToHex (4096 * 64 - 16) x)
        Word16Tree.ex2000
    , bench "fast-builder" $ whnf
        (\x -> FastBuilder.treeToHex defFastBuilderStrategy x)
        Word16Tree.ex2000
    , bench "bytestring" $ whnf
        (\x -> ByteString.treeToHex defStrategy x)
        Word16Tree.ex2000
    , bench "mason" $ whnf
        (\x -> Mason.treeToHex () x)
        Word16Tree.ex2000
    ]
  , bgroup "treeToHex-9000"
    [ bench "small-bytearray-builder" $ whnf
        (\x -> SmallByteArrayBuilder.treeToHex (4096 * 64 - 16) x)
        Word16Tree.ex9000
    , bench "bytestring" $ whnf
        (\x -> ByteString.treeToHex defStrategy x)
        Word16Tree.ex9000
    , bench "mason" $ whnf
        (\x -> Mason.treeToHex () x)
        Word16Tree.ex9000
    ]
  , bgroup "short-text-tree-1000"
    [ bench "small-bytearray-builder" $ whnf
        (\x -> SmallByteArrayBuilder.shortTextTree (4096 * 64 - 16) x)
        ShortTextTree.ex1000
    , bench "fast-builder" $ whnf
        (\x -> FastBuilder.shortTextTree defFastBuilderStrategy x)
        ShortTextTree.ex1000
    , bench "bytestring" $ whnf
        (\x -> ByteString.shortTextTree defStrategy x)
        ShortTextTree.ex1000
    , bench "mason" $ whnf
        (\x -> Mason.shortTextTree () x)
        ShortTextTree.ex1000
    ]
  , bgroup "byte-tree-2000"
    [ bench "small-bytearray-builder" $ whnf
        (\x -> SmallByteArrayBuilder.byteTree (4096 * 64 - 16) x)
        ByteTree.ex2000
    , bench "fast-builder" $ whnf
        (\x -> FastBuilder.byteTree defFastBuilderStrategy x)
        ByteTree.ex2000
    , bench "bytestring" $ whnf
        (\x -> ByteString.byteTree defStrategy x)
        ByteTree.ex2000
    , bench "mason" $ whnf
        (\x -> Mason.byteTree () x)
        ByteTree.ex2000
    ]
  ]

defStrategy :: E.AllocationStrategy
defStrategy = E.safeStrategy (4096 - 16) (32 * 1024 - 16)

defFastBuilderStrategy :: (Int,Int)
defFastBuilderStrategy = (1024 * 128 - 16, 1024 * 256 - 16)
