
def trace
  yield
rescue Exception => e
  puts e 
end

