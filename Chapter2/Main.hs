
import Text.ParserCombinators.Parsec hiding (spaces)
import System.Environment
import Control.Monad
import Numeric (readHex, readOct, readDec)

data LispVal = Atom String
             | List [LispVal]
             | DottedList [LispVal] LispVal
             | Number Integer
             | String String
             | Bool Bool
             deriving Show

symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

escaped :: Parser Char
escaped = do
               char '\\'
               x <- oneOf "\"\\rnt"
               return x

parseString :: Parser LispVal
parseString = do
                char '"'
                x <- many $ noneOf "\"\\" <|> escaped
                char '"'
                return $ String x

parseAtom :: Parser LispVal
parseAtom = do 
              first <- letter <|> symbol
              rest <- many (letter <|> digit <|> symbol)
              let atom = first:rest
              return $ case atom of 
                         "#t" -> Bool True
                         "#f" -> Bool False
                         _    -> Atom atom

parseNumber :: Parser LispVal
{-parseNumber = liftM (Number . read) $ many1 digit-}
parseNumber = (many1 digit) >>= (return . Number . read)
{-Exercise 1.1.1-}
{-parseNumber = do-}
                {-x <- many1 digit-}
                {-return $ (Number . read) x-}
{-Exercise 1.1.2-}
{-parseNumber = (many1 digit) >>= (return . Number . read)-}

parseNumberBase :: Parser LispVal
parseNumberBase = do 
                    char 'x'
                    x <- (many1 digit) <|> (many1 letter)
                    return $ Number $ fst $ (readHex x)!!0

parseExpr :: Parser LispVal
parseExpr = parseAtom
         <|> parseString
         <|> parseNumber

readExpr :: String -> String
readExpr input = case parse parseExpr "lisp" input of
    Left err -> "No match: " ++ show err
    Right x -> "Found value " ++ show x

main :: IO ()
main = do 
         (expr:_) <- getArgs
         putStrLn (readExpr expr)

