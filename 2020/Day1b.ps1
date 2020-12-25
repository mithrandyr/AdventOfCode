[cmdletBinding()]
param([parameter(ValueFromPipeline)][int[]]$data)

<#
The Elves in accounting are thankful for your help; one of them even offers you a starfish coin they had left over from a past vacation. They offer you a second one if you can find three numbers in your expense report that meet the same criteria.

Using the above example again, the three entries that sum to 2020 are 979, 366, and 675. Multiplying them together produces the answer, 241861950.
#>
begin { $dataList = [int[]]@() }
process{ $dataList += $data }
end {
    $searchCount = 0
    $arrayLocationFirst = 0
    $arrayLocationSecond = 1
    $searchLocation = 2
    while($true -or $arrayLocationFirst -eq ($dataList.Count - 2)) {
        #Write-Host "$searchCount -> $arrayLocationFirst, $arrayLocationSecond, $searchLocation"
        $searchCount += 1
        if($dataList[$arrayLocationFirst] + $dataList[$arrayLocationSecond] + $dataList[$searchLocation] -eq 2020) {
            Write-Host
            return $dataList[$arrayLocationFirst] * $dataList[$arrayLocationSecond] * $dataList[$searchLocation]
        }
        else {
            $searchLocation += 1
            if($searchLocation -eq $dataList.Count) {
                write-host "." -NoNewline
                $arrayLocationSecond += 1
                $searchLocation = $arrayLocationSecond + 1
            }
            if($arrayLocationSecond -eq ($dataList.Count -1)) {
                $arrayLocationFirst += 1
                $arrayLocationSecond = $arrayLocationFirst + 1
                $searchLocation = $arrayLocationFirst + 2
            }
        }
    }
}