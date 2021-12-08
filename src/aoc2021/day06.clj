(ns aoc2021.day06
  (:require
    [clojure.string :as str]))

(def initial-population
  (as-> (slurp "data/day06.txt") $
    (str/trim $)
    (str/split $ #",")
    (mapv (fn [s] (Integer/parseInt s)) $)))

(def next-age [6 0 1 2 3 4 5 6 7])

(defn life [n]
  (if (zero? n)
    [6 8]
    [(next-age n)]))

(defn nth-generation [n population]
  (reduce
    (fn [population _]
      (mapcat life population))
    population
    (range n)))

(def solution-1 (count (nth-generation 80 initial-population)))

(defn initial-lean-population
  "Return map of age to number of fish of that age."
  [population]
  (reduce
    (fn [m n]
      (update m n (fnil inc 0)))
    {}
    population))

(def +_ (fnil + 0))

(defn next-lean-population
  "Return map of age to number of fish of that age for next generation."
  [lean-population & _]
  (reduce-kv
    (fn [m k v]
      (if (zero? k)
        (-> m
            (update 6 +_ v)
            (update 8 +_ v))
        (update m (next-age k) +_ v)))
    {}
    lean-population))

(defn nth-lean-generation
  [n population]
  (reduce next-lean-population (initial-lean-population population) (range n)))

(def solution-2 (reduce + (vals (nth-lean-generation 256 initial-population))))
