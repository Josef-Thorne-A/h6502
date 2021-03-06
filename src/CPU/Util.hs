module CPU.Util (
    prettifyWord16
  , prettifyWord8
  , makeW16
  , toWord8
  , toWord16
  , toInt
  , firstNibble
  , splitW16
  , sliceBS
  , catMaybesV
  , bitGet
  , toChar
  ) where

--Code adapted from HNES

import           CPU.Types
import           Data.Bits       (bit, testBit, shiftL, shiftR, (.&.), (.|.))
import qualified Data.ByteString as BS
import           Data.Maybe      (fromJust, isJust)
import           Data.Vector     as V
import           Data.Word       (Word16, Word8)
import           Text.Printf     (printf)
import Data.Char (chr)

prettifyWord16 :: Word16 -> String
prettifyWord16 = printf "%04X"

prettifyWord8 :: Word8 -> String
prettifyWord8 = printf "%02X"

makeW16 :: Word8 -> Word8 -> Word16
makeW16 lo hi = toWord16 lo .|. toWord16 hi `shiftL` 8

toWord8 :: Word16 -> Word8
toWord8 = fromIntegral

toWord16 :: Word8 -> Word16
toWord16 = fromIntegral

toInt :: Word8 -> Int
toInt = fromIntegral

toChar :: Word8 -> Char
toChar = chr . fromIntegral 

splitW16 :: Word16 -> (Word8, Word8)
splitW16 w = (fromIntegral (w .&. 0xFF), fromIntegral (w `shiftR` 8))

firstNibble :: Word16 -> Word16
firstNibble = toWord16 . fst . splitW16

sliceBS :: Int -> Int -> BS.ByteString -> BS.ByteString
sliceBS from to xs = BS.take (to - from) (BS.drop from xs)

catMaybesV :: Vector (Maybe a) -> Vector a
catMaybesV = V.map fromJust . V.filter isJust

bitGet :: Byte -> Byte -> Word8
bitGet x b =
    case x of
      0 -> fromIntegral $ fromEnum $ testBit  b 0
      1 -> fromIntegral $ fromEnum $ testBit  b 1
      2 -> fromIntegral $ fromEnum $ testBit  b 2
      3 -> fromIntegral $ fromEnum $ testBit  b 3
      4 -> fromIntegral $ fromEnum $ testBit  b 4
      5 -> fromIntegral $ fromEnum $ testBit  b 5
      6 -> fromIntegral $ fromEnum $ testBit  b 6
      7 -> fromIntegral $ fromEnum $ testBit  b 7
      _ -> 0

