module Format
  EMAIL = Regexp.new(/^\S+\@(\[?)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,4}|[0-9]{1,4})(\]?)$/ix)  
  ID = Regexp.new(/^[0-9]+$/i)
  UUID = Regexp.new(/[a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12}/)
end