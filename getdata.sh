url_base="http://127.0.0.1:3000/api/"
url_part='users'
email='test@example.com'
pasword=$email

curl -XPOST -sd '{"user":{"email":"'${email}'","password":"'${pasword}'","password_confirmation":"'${pasword}'"}}' -H 'Content-Type:application/json' \
"${url_base}/${url_part}" | jq .

pause

url_part='users/login'

token=`curl -XPOST -sd '{"user":{"email":"'${email}'","password":"'${pasword}'","password_confirmation":"'${pasword}'"}}' -H 'Content-Type:application/json' \
"${url_base}/${url_part}" | jq '.token' | tr -d '"'`

# echo $token

url_part='categories'
data='{"name":"Test category","description":"test description"}'
catid=`curl -XPOST -H "auth-token:${token}" -H 'Content-Type:application/json' -sd "{\"category\":${data}}"  "${url_base}${url_part}" | jq '.id'`
#-H 'Authorization: Basic YXF1YTphcXVh' -v

echo ${catid}
url_part='posts'
data="{\"name\":\"Test post\",\"content\":\"Test content\",\"category_id\":\"${catid}\"}"
postid=`curl -XPOST -H "auth-token:${token}" -H 'Content-Type:application/json' -sd "{\"post\":${data}}" "${url_base}${url_part}" | jq '.id'`
# | less
# -H 'Authorization: Basic YXF1YTphcXVh' -v

url_part="posts/${postid}/comments"
for i in $(seq 1 10); do
  echo item: $i
  data="{\"author\":\"Test Author ${i}\",\"content\":\"Test content ${i}\"}"
  curl -XPOST -H "auth-token:${token}" -H 'Content-Type:application/json' -sd "{\"comment\":${data}}" "${url_base}${url_part}" | jq . | less
done
