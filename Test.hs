import Lexer
import Parser
import AST
import Text.Show.Pretty
import System.Environment(getArgs)

main :: IO ()
main = mapM_ testFile =<< getArgs

testFile :: FilePath -> IO ()
testFile file =
  do txt <- readFile file
     let tokens = lexer txt
     mapM_ (putStrLn . tokenText) tokens
     putStrLn "----------------"

     case parseExpr tokens of
       Left err -> putStrLn err
       Right a  -> putStrLn (ppShow a)



