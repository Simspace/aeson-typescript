
module Main where

import Test.Tasty

import TaggedObjectNoTagSingleConstructors as TaggedObjectNoTagSingleConstructors
import TaggedObjectTagSingleConstructors as TaggedObjectTagSingleConstructors
import TwoElemArrayNoTagSingleConstructors as TwoElemArrayNoTagSingleConstructors
import Untagged as Untagged

allTests :: TestTree
allTests = testGroup "All unit tests" [TaggedObjectTagSingleConstructors.tests
                                      , TaggedObjectNoTagSingleConstructors.tests
                                      , TwoElemArrayNoTagSingleConstructors.tests
                                      , Untagged.tests]

main = defaultMainWithIngredients defaultIngredients $ allTests
