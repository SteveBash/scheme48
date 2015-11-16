
import Control.Monad

main :: IO ()
main = do
    output <- liftM ("Hello, " ++) getLine
    putStrLn output
