# https://github.com/internetarchive/wayback/tree/master/wayback-cdx-server
# Using: ./webarchive.ps1 domain.name

$domain = $args[0]
$request = 'http://web.archive.org/cdx/search/cdx?output=json&url=' + $domain
$response = curl $request | ConvertFrom-Json
$data = $response
$data = $data[1..($data.count - 1)] #drop metadata

$result = @()
foreach ($item in $data) {
  $time = $item[1]
  $path = $item[2]
  $link = 'http://web.archive.org/web/' + $time + '/' + $path
  $result += $link

  Write-Host $link
}

Set-Content -Path ('./' + $domain + '.txt') -Value $result