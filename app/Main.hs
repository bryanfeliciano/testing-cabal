{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Text (Text)
import qualified Data.Text.IO as T 
import Network.Wreq
import GHC.Generics
import Data.Aeson
import Control.Lens

data TranslateRequest = TranslateRequest {
  q :: Text,
  source :: Text,
  target :: Text,
  format :: Text
} deriving (Generic)

instance ToJSON TranslateRequest

data TranslateResponse = TranslateResponse { translatedText :: Text } deriving (Generic)

instance FromJSON TranslateResponse

main :: IO ()
main = do
  rsp <- asJSON =<< post "https://translate.argosopentech.com/languages" (toJSON (TranslateRequest {
    q      = "this is a haskell test",
    source = "en",
    target = "es",
    format = "text"
  }))
  T.putStrLn (translatedText (rsp ^. responseBody))

