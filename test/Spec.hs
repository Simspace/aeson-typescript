
module Main where

import Test.Hspec

import HigherKind as HigherKind
import ObjectWithSingleFieldNoTagSingleConstructors as ObjectWithSingleFieldNoTagSingleConstructors
import ObjectWithSingleFieldTagSingleConstructors as ObjectWithSingleFieldTagSingleConstructors
import TaggedObjectNoTagSingleConstructors as TaggedObjectNoTagSingleConstructors
import TaggedObjectTagSingleConstructors as TaggedObjectTagSingleConstructors
import TwoElemArrayNoTagSingleConstructors as TwoElemArrayNoTagSingleConstructors
import TwoElemArrayTagSingleConstructors as TwoElemArrayTagSingleConstructors
import Untagged as Untagged

main = hspec $ do
  ObjectWithSingleFieldTagSingleConstructors.tests
  ObjectWithSingleFieldNoTagSingleConstructors.tests
  TaggedObjectTagSingleConstructors.tests
  TaggedObjectNoTagSingleConstructors.tests
  TwoElemArrayTagSingleConstructors.tests
  TwoElemArrayNoTagSingleConstructors.tests
  Untagged.tests
  HigherKind.tests
