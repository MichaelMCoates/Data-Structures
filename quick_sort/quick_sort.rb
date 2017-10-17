class QuickSort

  # Not in-place.
  def self.naive(array)
    return array if array.empty?

    pivot_idx = rand(array.length)
    array[array.length - 1], array[pivot_idx] = array[pivot_idx], array[array.length - 1]

    pivot = array.shift

    left = []
    right = []

    array.each do |el|
      if el < pivot
        left.push(el)
      else
        right.push(el)
      end
    end

    naive(left) + [pivot] + naive(right)
  end

  def self.in_place!(array, start_idx = 0, length = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    return array if length < 2

    pivot_idx = partition(array, start_idx, length, &prc)

    left_length = pivot_idx - start_idx
    right_length = length - (left_length + 1)
    in_place!(array, start_idx, left_length, &prc)
    in_place!(array, pivot_idx + 1, right_length, &prc)

    array
  end

  def self.partition(array, start_idx, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    pivot_idx = start_idx
    pivot = array[start_idx]
    end_idx = start_idx + length

    ((start_idx + 1)...end_idx).each do |idx|
      if prc.call(pivot, array[idx]) > 0
        array[idx], array[pivot_idx + 1] = array[pivot_idx + 1], array[idx]
        pivot_idx += 1
      end
    end

    array[start_idx], array[pivot_idx] = array[pivot_idx], array[start_idx]

    pivot_idx
  end
end
