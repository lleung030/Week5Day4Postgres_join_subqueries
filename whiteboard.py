# Given two arrays, write a function to compute their intersection.
# Example 1:
# Input: nums1 = [1,2,2,1], nums2 = [2,2]
# Output: [2]
# Example 2:
# Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
# Output: [9,4]
# Note:
# Each element in the result must be unique.
# The result can be in any order.

#loop through first list
#loop through second list 
#if a number from the second is found in the first list
#append that to an empty list 

# nums1 = [4,9,5] 
# nums2 = [9,4,9,8,4]

nums1 = [1,2,2,1] 
nums2 = [2,2]

def intersect(nums1, nums2):
    lst = []
    for x in nums1:
        for y in nums2:
            if x==y:
                lst.append(x)
    return list(set(lst))

print(intersect(nums1,nums2))