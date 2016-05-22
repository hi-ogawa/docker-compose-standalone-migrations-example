{-# LANGUAGE OverloadedStrings #-}
module Database where

import Control.Monad.Reader
import Data.ByteString
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToField (toField)
import Database.PostgreSQL.Simple.ToRow


-----------------------
-- monadic interface --

type DbMonad a = ReaderT Connection IO a

runDb :: ByteString -> DbMonad a -> IO a
runDb pgUrl rt = do
  conn <- connectPostgreSQL pgUrl
  runReaderT rt conn <* liftIO (close conn)

tquery :: (MonadIO m, ToRow q, FromRow r) => Connection -> Query -> q -> m [r]
tquery c q r = liftIO $ query c q r

tquery_ :: (MonadIO m, FromRow r) => Connection -> Query -> m [r]
tquery_ c q = liftIO $ query_ c q


--------------------
-- database table --

data User = User {
  emailField :: String,
  passwordField :: String
  } deriving (Show)


instance FromRow User where
  fromRow = User <$> field <*> field

instance ToRow User where
  toRow (User email password) = [toField email, toField password]


---------
-- api --

index :: DbMonad [User]
index = join $ tquery_ <$> ask <*> pure q
  where
    q = "select email, password from \"user\""

create :: User -> DbMonad [User]
create user = join $ tquery <$> ask <*> pure q <*> pure user
  where
    q = "insert into \"user\" (email, password) values (?, ?) returning email, password"
