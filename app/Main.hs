module Main where

import           Control.Monad.Trans.Maybe
import qualified Data.ByteString.Lazy      as LB
import           Lib
import           System.Environment        (getArgs)
import           System.FilePath           (takeFileName)

usage = "hhash [-a {md5 | sha1 | sha256 | sha384 | sha512 | ripemd160}] path"
defaultAlg = "sha256"

hash :: [String] -> MaybeT IO String
hash ("-a":alg:path:_) = (\x -> x ++ "  " ++ takeFileName path) <$> (MaybeT $ getHash alg <$> LB.readFile path)
hash ("-h":_) = MaybeT $ return . Just $ usage
hash ("--help":_) = MaybeT $ return . Just $ usage
hash args = hash ("-a":defaultAlg:args)

main :: IO ()
main = do
    args <- getArgs
    h <- runMaybeT $ hash args
    case h of
      Just s -> putStrLn s
      Nothing -> putStrLn $ "Unsupported usage. \r\n" ++ usage
