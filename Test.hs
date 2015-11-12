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
     let tokens = lexer True txt
     case parseModule tokens of
       Left err -> putStrLn err
       Right a  -> putStrLn (ppShow (a (ConName "TheModule")))



