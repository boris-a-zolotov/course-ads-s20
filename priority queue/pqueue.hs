import Data.List

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

main=do
  putStrLn $ show $ queueProcess [2,3,1,6,-1,4,5] [] 0
