def my_map(arr, &proc)
    new_arr = []
    arr.each{ | num | new_arr << proc.call(num) }
    new_arr
end

def my_select(arr, &proc)
    new_arr = []
    arr.each{ | num | 
        if proc.call(num) 
            new_arr << num
        end
    }
    new_arr
end

def my_count(arr, &proc)
    i = 0
    arr.each{ | num | 
        if proc.call(num) 
            i+=1
        end
    }
    i
end

def my_any?(arr, &proc)
    
    arr.each{ | el |
        if proc.call(el)
            return true 
        end
    }

    false
end

def my_all?(arr, &proc)

    arr.each{ | el |
        unless proc.call(el)
            return false 
        end
    }
    
    true
end

def my_none?(arr, &proc)

    arr.each{ | el |
        if proc.call(el)
            return false 
        end
    }
    
    true
end

def reverser(string, &proc)
    proc.call(string.reverse)
end

def word_changer(string, &proc)
    words = string.split(" ")
    new_arr = []

    words.each{ |word|
        new_arr << proc.call(word)
    }

    new_arr.join(" ")
end

def greater_proc_value(num, proc1, proc2)
    if proc1.call(num) > proc2.call(num)
        proc1.call(num) 
    else
        proc2.call(num)
    end
end

def and_selector(arr, proc1, proc2)

    new_arr = []

    arr.each{ |el|
        if proc1.call(el) && proc2.call(el)
            new_arr << el
        end
    }

    new_arr
end

def alternating_mapper(arr, proc1, proc2)

    new_arr = []

    arr.each.with_index{ |el, idx|
        if idx % 2 == 0
            new_arr << proc1.call(el)
        else
            new_arr << proc2.call(el)
        end
    }

    new_arr
end