## The functions do things...  I've commented them line by line?

## The following funciton creates a special matrix object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {                                     #we now have a function called makeCacheMatrix() which takes a matrix as its argument.  let's imagine that a <- makeCacheMatrix(matrix(blah blah blah))
     inv <- NULL                                                                #the value for "inv" within the environment of this function shall be NULL
     set <- function(y) {                                                       #we create a function within f1env called "set".  It takes an argument, and sets x(within f1env (notice the use of <<- to change within parent) to be that, also resets "inv")
          x <<- y
          inv <<- NULL
     }
     get <- function() x                                                        # we create another function called "get" which spits out the value of x within f1env.
     setinverse <- function(inverse) inv <<- inverse                            # we create a function called "setinverse" which takes an argument and puts it into the value of f1env "inv"
     getinverse <- function() inv                                               # this function spits out whatever value of "inv" is within the parent environment
     list(set = set,                                                            # finally, we return a list of functions, whose parent environment is f1env.  in our example, this list of functions is called "a"
          get = get,
          setinverse =setinverse,
          getinverse = getinverse)
}


## The following function computes the inverse of the matrix returned by the above
## function.  If the inverse has already been calculated, then the function should
## retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {                                                #this new function takes our list of functions, with the intent of finding an inverse.
        ## Return a matrix that is the inverse of 'x'
     inv <- x$getinverse()                                                      #first, it looks in a.env and grabs the value of "inv"
     if(!is.null(inv)) {                                                        #if that value it grabs is not null, it decides it's done, and spits it out.  (sneaky, it actually gets the cached value before it says it's getting the cached value!)
               message("gettting cached data")
               return(inv)
     }
     data <- x$get()                                                            #presumably, otherwise the value will be null.  now there is work to do, so the function grabs the data from a.env
     inv <- solve(data,...)                                                     # then the function inverts the data, and puts it into "inv" in funct.env
     x$setinverse(inv)                                                          #then it takes that value and gives it to the function setinverse, which, using the <<- operator, puts it in the cache of its parent, which in this case, is a.env
     return(inv)                                                                #the function then finally shows you the value of "inv" that it gave to a.env through setinverse()
}
