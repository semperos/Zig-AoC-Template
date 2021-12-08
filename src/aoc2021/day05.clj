(ns aoc2021.day05
  (:require
    [clojure.string :as str]))

(def line-segments
  (->>
    (slurp "data/day05.txt")
    (str/split-lines)
    (mapv (fn [line]
            (mapv (fn [coord]
                    (mapv (fn [num-str] (Integer/parseInt num-str))
                          (str/split coord #",")))
                  (str/split line #" -> "))))))

(defn straight?
  [[[x1 y1] [x2 y2]]]
  (or (= x1 x2)
      (= y1 y2)))

(def straight-segments
  (filterv straight? line-segments))

(defn rng
  "Range that goes low to high or high to low,
  _inclusive_ of m and n."
  [m n]
  (if (> n m)
    (range m (inc n))
    (loop [m m res []]
      (if (= m n)
        (conj res m)
        (recur (dec m) (conj res m))))))

(defn straight-points
  [[[x1 y1] [x2 y2]]]
  (if (= x1 x2)
    (mapv (fn [y] [x1 y]) (rng y1 y2))
    (mapv (fn [x] [x y1]) (rng x1 x2))))

(def straight-segment-points (mapcat straight-points straight-segments))

(def solution-1
  (->>
    (reduce
      (fn [m point]
        (update m point (fnil inc 0)))
      {}
      straight-segment-points)
    (filterv
      (fn [[_k v]]
        (>= v 2)))
    count))

(defn diagonal-points
  [[[x1 y1] [x2 y2]]]
  (mapv (fn [x y] [x y]) (rng x1 x2) (rng y1 y2)))

(def diagonal-segments
  (filterv (complement straight?) line-segments))

(def diagonal-segment-points (mapcat diagonal-points diagonal-segments))

(def all-points (concat straight-segment-points diagonal-segment-points))

(def solution-2
  (->>
    (reduce
      (fn [m point]
        (update m point (fnil inc 0)))
      {}
      all-points)
    (filterv
      (fn [[_k v]]
        (>= v 2)))
    count))
