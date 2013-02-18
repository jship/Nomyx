-----------------------------------------------------------------------------
--
-- Module      :  Utils
-- Copyright   :
-- License     :  AllRightsReserved
--
-- Maintainer  :
-- Stability   :
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

{-# LANGUAGE NamedFieldPuns #-}
    
module Utils where

import Data.Maybe
import Data.Char
import Control.Monad.State
import Types
import Language.Nomyx.Expression
import Data.List
import Control.Applicative

         
-- | this function will return just a if it can cast it to an a.
maybeRead :: Read a => String -> Maybe a
maybeRead = fmap fst . listToMaybe . reads



-- | Replaces all instances of a value in a list by another value.
replace :: Eq a => a   -- ^ Value to search
        -> a   -- ^ Value to replace it with
        -> [a] -- ^ Input list
        -> [a] -- ^ Output list
replace x y = map (\z -> if z == x then y else z)



yes = ["o", "oui", "y", "yes", "v", "vrai", "true"]
toLowerS = map toLower
isYes a = toLowerS a `elem` yes

-- | generic function to say things on transformers like GameState, ServerState etc.
say :: String -> StateT a IO ()
say = lift . putStrLn

liftT :: Show s => State s a -> StateT s IO a
liftT st = do
    s1 <- get
    let (a, s) = runState st s1
    put s
    return a


findPlayer :: PlayerName -> State Multi (Maybe PlayerMulti)
findPlayer name = find (\PlayerMulti {mPlayerName = pname} -> pname==name) <$> gets mPlayers

findPlayer' :: PlayerNumber -> State Multi (Maybe PlayerMulti)
findPlayer' pn = find (\PlayerMulti {mPlayerNumber} -> pn==mPlayerNumber) <$> gets mPlayers

nomyxURL :: Network -> String
nomyxURL (Network host port) = "http://" ++ host ++ ":" ++ (show port)

getPlayersName :: PlayerNumber -> Multi -> PlayerName
getPlayersName pn multi = do
   case find (\(PlayerMulti n _ _ _ _ _) -> n==pn) (mPlayers multi) of
      Nothing -> error "getPlayersName: No player by that number"
      Just pm -> mPlayerName pm

getPlayersName' :: Game -> PlayerNumber -> PlayerName
getPlayersName' g pn = do
   case find (\(PlayerInfo n _) -> n==pn) (players g) of
      Nothing -> error "getPlayersName: No player by that number in that game"
      Just pm -> playerName pm

-- | returns the game the player is in
getPlayersGame :: PlayerNumber -> Multi -> Maybe Game
getPlayersGame pn multi = do
        pi <- find (\(PlayerMulti n _ _ _ _ _) -> n==pn) (mPlayers multi)
        gn <- inGame pi
        find (\(Game {gameName=name}) -> name==gn) (games multi)

getPlayersNameMay :: Game -> PlayerNumber -> Maybe PlayerName
getPlayersNameMay g pn = do
   case find (\(PlayerInfo n _) -> n==pn) (players g) of
      Nothing -> Nothing
      Just pm -> Just $ playerName pm


