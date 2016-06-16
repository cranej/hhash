module Lib
    ( md5
    , getHash
    ) where

import           Control.Applicative  ((<*>))
import           Crypto.Hash
import           Data.ByteString.Lazy

hashTypes =
  [("md5", show . (hashlazy :: ByteString -> Digest MD5))
  ,("sha1", show . (hashlazy :: ByteString -> Digest SHA1))
  ,("sha256", show . (hashlazy :: ByteString -> Digest SHA256))
  ,("sha384", show . (hashlazy :: ByteString -> Digest SHA384))
  ,("sha512", show . (hashlazy :: ByteString -> Digest SHA512))
  ,("ripemd160", show . (hashlazy :: ByteString -> Digest RIPEMD160))
  ]

md5 :: ByteString -> Digest MD5
md5 = hashlazy

getHash :: String -> ByteString -> Maybe String
getHash ht bs =
   lookup ht hashTypes <*> Just bs
