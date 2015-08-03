
module Nomyx.Core.Engine.Utils(
   (===),
   replaceWith,
   tracePN,
   traceData,
   parse822Time,
   sndMaybe,
   mapStateIO,
   getFreeNumber,
   sel,
   getL,
   module Debug.Trace) where

import           Control.Lens           hiding (runIdentity)
import           Control.Monad.Identity
import           Control.Monad.State
import           Data.Maybe             (fromJust)
import           Data.Time
import           Data.Typeable          (Typeable, cast)
import           Debug.Trace            (trace)
import           Debug.Trace.Helpers    (traceM)
import           System.Locale          (defaultTimeLocale, rfc822DateFormat)

-- | an equality that tests also the types.
(===) :: (Typeable a, Typeable b, Eq b) => a -> b -> Bool
(===) x y = cast x == Just y

-- | Replaces all instances of a value in a list by another value.
replaceWith :: (a -> Bool)   -- ^ Value to search
        -> a   -- ^ Value to replace it with
        -> [a] -- ^ Input list
        -> [a] -- ^ Output list
replaceWith f y = map (\z -> if f z then y else z)

tracePN :: (Monad m) => Int -> String -> m ()
tracePN pn s = traceM $ "Player " ++ (show pn) ++ " " ++ s

traceData :: (Show a) => String -> a -> a
traceData s a = trace (s ++ " " ++ (show a)) a

parse822Time :: String -> UTCTime
parse822Time = zonedTimeToUTC
              . fromJust
              . parseTime defaultTimeLocale rfc822DateFormat

sndMaybe :: (a, Maybe b) -> Maybe (a,b)
sndMaybe (a, Just b) = Just (a,b)
sndMaybe (_, Nothing) = Nothing

mapStateIO :: Show s => State s a -> StateT s IO a
mapStateIO = mapStateT $ return . runIdentity

getFreeNumber :: (Eq a, Num a, Enum a) => [a] -> a
getFreeNumber l = head [ a | a <- [1..], notElem a l]

sel :: [a]   -- ^ List of indices to select
    -> [Int] -- ^ List of elements
    -> [a]   -- ^ List composed of elements selected from original set by indices provided
sel xs is = map (\i -> xs!!i) is

getL :: Getting a s a -> s -> a
getL = flip (^.)
