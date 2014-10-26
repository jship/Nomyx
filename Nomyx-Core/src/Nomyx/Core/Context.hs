module Nomyx.Core.Context (
  unQualImports,
  qualImports,
  defaultPackages
) where


unQualImports :: [String]
unQualImports =  ["Language.Nomyx",
                  "Language.Nomyx.Examples",
                  "Safe",
                  "Data.Typeable",
                  "Data.Lens",
                  "Prelude",
                  "Data.Function",
                  "Control.Applicative",
                  "Control.Arrow",
                  "Control.Monad",
                  "Control.Monad.Cont",
                  "Control.Monad.Error",
                  "Control.Monad.Fix",
                  "Control.Monad.Identity",
                  "Control.Monad.RWS",
                  "Control.Monad.Reader",
                  "Control.Monad.State",
                  "Control.Monad.State",
                  "Control.Monad.Writer",
                  "Control.Monad.Loops",
                  "Data.Array",
                  "Data.Bits",
                  "Data.Bool",
                  "Data.Char",
                  "Data.Complex",
                  "Data.Dynamic",
                  "Data.Either",
                  "Data.Eq",
                  "Data.Fixed",
                  "Data.Graph",
                  "Data.Int",
                  "Data.Ix",
                  "Data.List",
                  "Data.Maybe",
                  "Data.Monoid",
                  "Data.Ord",
                  "Data.Ratio",
                  "Data.Semigroup",
                  "Data.Tree",
                  "Data.Tuple",
                  "Data.Typeable",
                  "Data.Word",
                  "System.Random"]

defaultPackages :: [String]
defaultPackages = ["Nomyx-Language",
                   "array",
                   "base",
                   "bytestring",
                   "containers",
                   "text"]

qualImports :: [(String, Maybe String)]
qualImports = [("Control.Category", Just "C"),
               ("Data.ByteString", Just "BS"),
               ("Data.ByteString.Char8", Just "BSC"),
               ("Data.ByteString.Lazy", Just "BSL"),
               ("Data.ByteString.Lazy.Char8", Just "BSLC"),
               ("Data.Foldable", Just "Data.Foldable"),
               ("Data.IntMap", Just "IM"),
               ("Data.IntSet", Just "IS"),
               ("Data.Map", Just "M"),
               ("Data.Sequence", Just "Data.Sequence"),
               ("Data.Set", Just "S"),
               ("Data.Text", Just "T"),
               ("Data.Traversable", Just "Data.Traversable")]
