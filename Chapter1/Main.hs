
module Main where
import System.Environment

{-Exercise 2-}
{-main :: IO()-}
{-main = do-}
    {-args <- getArgs-}
    {-putStrLn $ "Hello, " ++ (simpleArithmetic $ args!!0) ++ ( simpleArithmetic $ args!!1)-}
    {-where-}
        {-simpleArithmetic :: String -> String-}
        {-simpleArithmetic x = show $ read x + 1-}

{-Exercise 3-}
{-main :: IO()-}
{-main = do-}
    {-putStrLn $ "Tell me your name:"-}
    {-name <- getLine -}
    {-putStrLn $ "Hello, " ++ name-}
