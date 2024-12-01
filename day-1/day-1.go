package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

func main() {
	// parsing
	file, err := os.Open("input.txt")
	if err != nil {
		fmt.Println("Error opening file:", err)
		return
	}
	defer file.Close()

	var left []int
	var right []int

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		parts := strings.Fields(line)
		numLeft, _ := strconv.Atoi(parts[0])
		numRight, _ := strconv.Atoi(parts[1])
		left = append(left, numLeft)
		right = append(right, numRight)
	}

	sort.Ints(left)
	sort.Ints(right)

	// part 1
	var distances []int
	for i := 0; i < len(left); i++ {
		diff := left[i] - right[i]
		if diff < 0 {
			diff = -diff
		}
		distances = append(distances, diff)
	}

	totalDistance := 0
	for _, distance := range distances {
		totalDistance += distance
	}

	fmt.Printf("Total distance: %v\n", totalDistance)

	// part 2
	valueCounts := make(map[int]int)
	for _, value := range right {
		valueCounts[value]++
	}

	var similarityScores []int
	for _, value := range left {
		count := valueCounts[value]
		similarityScores = append(similarityScores, count*value)
	}

	totalSimilarity := 0
	for _, score := range similarityScores {
		totalSimilarity += score
	}

	fmt.Printf("Total similarity: %v\n", totalSimilarity)
}
