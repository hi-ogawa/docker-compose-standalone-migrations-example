module Main where

import Control.Monad.IO.Class (liftIO)
import qualified Data.ByteString as B
import qualified Data.Text as T
import qualified Data.Text.Encoding as E
import System.Environment

import Database

main :: IO ()
main = do
  pgUrl <- E.encodeUtf8 . T.pack . head <$> getArgs
  runDb pgUrl example

example :: DbMonad ()
example = do
  create $ User "test@test.com" "asdfjkl;"
  liftIO . print =<< index
  create $ User "foo@bar.com" "12345678"
  liftIO . print =<< index
