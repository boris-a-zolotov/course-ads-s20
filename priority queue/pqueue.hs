import Data.List
import Data.String
import Text.Printf

deleteMin :: [a] -> [a]
deleteMin [] = []
deleteMin (q:ls) = ls

queueInsert :: (Ord a) => a -> Integer -> [(a,Integer)] -> [(a,Integer)]
queueInsert x n [] = [(x,n)]
queueInsert x n ((a,b):ls) = if x<a then ((x,n):((a,b):ls)) else (a,b):(queueInsert x n ls)

queueProcess :: [Integer] -> [(Integer,Integer)] -> Integer -> [(Integer,Integer)]
queueProcess [] x y = x
queueProcess (-1:ls) x y = queueProcess ls (deleteMin x) (y+1)
queueProcess (q:ls) x y = queueProcess ls (queueInsert q y x) (y+1)

totikz :: (Integer,Integer) -> String -> Integer -> String
totikz (a,b) col t = printf "\n  \\draw (%d,%d) -- (%d,%d); \\draw[%s] (%d,%d) -- (%d,0);" b a t a col t a t

-- Цвет || Элементы || Текущий список с временами || Номер шага || tikz-код
queueProcessTikz :: String -> [Integer] -> [(Integer,Integer)] -> Integer -> String -> String
queueProcessTikz col [] x y s = s ++ (foldl (++) "" (map (\r -> totikz r col y) x)) ++ "  }"
queueProcessTikz col (-1:ls) x y s = queueProcessTikz col ls (deleteMin x) (y+1) (s ++ (totikz (head x) col y))
queueProcessTikz col (q:ls) x y s = queueProcessTikz col ls (queueInsert q y x) (y+1) s

main=do
  putStrLn $ queueProcessTikz "red" [30,-1,18,11,14,-1,-1,-1,1,9,3,-1,-1,6,1000,29,-1,22,7,23,25,2,16,24,-1,27,10,-1,-1,-1,28,-1,-1,5,13,21,17,19,-1,-1,15,12,26,-1,-1,20,-1,8] [] 0 "\\tikz[scale=0.3]{"
  putStrLn $ queueProcessTikz "blue" [30,-1,18,11,14,-1,-1,-1,1,9,3,-1,-1,6,4,29,-1,22,7,23,25,2,16,24,-1,27,10,-1,-1,-1,28,-1,-1,5,13,21,17,19,-1,-1,15,12,26,-1,-1,20,-1,8] [] 0 "\\tikz[scale=0.3]{"