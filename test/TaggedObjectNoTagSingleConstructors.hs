{-# LANGUAGE QuasiQuotes, OverloadedStrings, TemplateHaskell, RecordWildCards, ScopedTypeVariables, NamedFieldPuns #-}

module TaggedObjectNoTagSingleConstructors (tests) where

import Data.Aeson as A
import Data.Aeson.TH as A
import Data.Aeson.TypeScript.TH
import Data.Monoid
import Data.Proxy
import Data.String.Interpolate.IsString
import qualified Data.Text as T
import Prelude hiding (Double)
import System.FilePath
import System.IO.Unsafe (unsafePerformIO)
import Test.Hspec
import Util


data Unit = Unit
$(deriveJSON A.defaultOptions ''Unit)
$(deriveTypeScript A.defaultOptions ''Unit)

data OneFieldRecordless = OneFieldRecordless Int
$(deriveJSON A.defaultOptions ''OneFieldRecordless)
$(deriveTypeScript A.defaultOptions ''OneFieldRecordless)

data OneField = OneField { simpleString :: String }
$(deriveJSON A.defaultOptions ''OneField)
$(deriveTypeScript A.defaultOptions ''OneField)

data TwoFieldRecordless = TwoFieldRecordless Int String
$(deriveJSON A.defaultOptions ''TwoFieldRecordless)
$(deriveTypeScript A.defaultOptions ''TwoFieldRecordless)

data TwoField = TwoField { doubleInt :: Int
                         , doubleString :: String }
$(deriveJSON A.defaultOptions ''TwoField)
$(deriveTypeScript A.defaultOptions ''TwoField)

data TwoConstructor = Con1 { con1String :: String }
                    | Con2 { con2String :: String
                           , con2Int :: Int }
$(deriveJSON A.defaultOptions ''TwoConstructor)
$(deriveTypeScript A.defaultOptions ''TwoConstructor)

declarations = ((getTypeScriptDeclarations (Proxy :: Proxy Unit)) <>
                 (getTypeScriptDeclarations (Proxy :: Proxy OneFieldRecordless)) <>
                 (getTypeScriptDeclarations (Proxy :: Proxy OneField)) <>
                 (getTypeScriptDeclarations (Proxy :: Proxy TwoFieldRecordless)) <>
                 (getTypeScriptDeclarations (Proxy :: Proxy TwoField)) <>
                 (getTypeScriptDeclarations (Proxy :: Proxy TwoConstructor))
               )

typesAndValues = [(getTypeScriptType (Proxy :: Proxy Unit) , A.encode Unit)
                 , (getTypeScriptType (Proxy :: Proxy OneFieldRecordless) , A.encode $ OneFieldRecordless 42)
                 , (getTypeScriptType (Proxy :: Proxy OneField) , A.encode $ OneField "asdf")
                 , (getTypeScriptType (Proxy :: Proxy TwoFieldRecordless) , A.encode $ TwoFieldRecordless 42 "asdf")
                 , (getTypeScriptType (Proxy :: Proxy TwoField) , A.encode $ TwoField 42 "asdf")
                 , (getTypeScriptType (Proxy :: Proxy TwoConstructor) , A.encode $ Con1 "asdf")
                 , (getTypeScriptType (Proxy :: Proxy TwoConstructor) , A.encode $ Con2 "asdf" 42)
                 ]

tests = describe "TaggedObject with tagSingleConstructors=False" $ do
  it "type checks everything with tsc" $ do
    testTypeCheckDeclarations declarations typesAndValues

main = hspec tests
