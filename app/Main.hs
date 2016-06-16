module Main where

import qualified Data.ByteString.Lazy as LB
import           Lib
import           System.Environment   (getArgs)

usage = "hhash [-a {md5 | sha1 | sha256 | sha384 | sha512 | ripemd160}] path"
defaultAlg = "sha256"

hash :: [String] -> IO(Maybe String)
hash ("-a":alg:path:_) = getHash alg <$> LB.readFile path
hash ("-h":_) = return . Just $ usage
hash ("--help":_) = return . Just $ usage
hash args = hash ("-a":defaultAlg:args)

main :: IO ()
main = do
    args <- getArgs
    h <- hash args
    case h of
      Just s -> putStrLn s
      Nothing -> putStrLn $ "Unsupported usage. \r\n" ++ usage
