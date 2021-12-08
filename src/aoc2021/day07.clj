(ns aoc2021.day07
  (:require
    [clojure.string :as str]))

(def initial-positions
  (as-> (slurp "data/day07.txt") $
    (str/trim $)
    (str/split $ #",")
    (mapv (fn [s] (Integer/parseInt s)) $)))
