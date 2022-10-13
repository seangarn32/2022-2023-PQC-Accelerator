library ieee;
use ieee.std_logic_1164.all;

entity mux_256 is
generic (N:INTEGER:=256);
	port( A		: in STD_LOGIC_VECTOR(8*N-1 downto 0);
	      SEL	: in STD_LOGIC_VECTOR(7 downto 0);
	      B		: out STD_LOGIC_VECTOR(7 downto 0) 
);
end mux_256;

architecture a of mux_256 is
begin

with SEL select B <=
A(7 downto 0) when "00000000",
A(15 downto 8) when "00000001",
A(23 downto 16) when "00000010",
A(31 downto 24) when "00000011",
A(39 downto 32) when "00000100",
A(47 downto 40) when "00000101",
A(55 downto 48) when "00000110",
A(63 downto 56) when "00000111",
A(71 downto 64) when "00001000",
A(79 downto 72) when "00001001",
A(87 downto 80) when "00001010",
A(95 downto 88) when "00001011",
A(103 downto 96) when "00001100",
A(111 downto 104) when "00001101",
A(119 downto 112) when "00001110",
A(127 downto 120) when "00001111",
A(135 downto 128) when "00010000",
A(143 downto 136) when "00010001",
A(151 downto 144) when "00010010",
A(159 downto 152) when "00010011",
A(167 downto 160) when "00010100",
A(175 downto 168) when "00010101",
A(183 downto 176) when "00010110",
A(191 downto 184) when "00010111",
A(199 downto 192) when "00011000",
A(207 downto 200) when "00011001",
A(215 downto 208) when "00011010",
A(223 downto 216) when "00011011",
A(231 downto 224) when "00011100",
A(239 downto 232) when "00011101",
A(247 downto 240) when "00011110",
A(255 downto 248) when "00011111",
A(263 downto 256) when "00100000",
A(271 downto 264) when "00100001",
A(279 downto 272) when "00100010",
A(287 downto 280) when "00100011",
A(295 downto 288) when "00100100",
A(303 downto 296) when "00100101",
A(311 downto 304) when "00100110",
A(319 downto 312) when "00100111",
A(327 downto 320) when "00101000",
A(335 downto 328) when "00101001",
A(343 downto 336) when "00101010",
A(351 downto 344) when "00101011",
A(359 downto 352) when "00101100",
A(367 downto 360) when "00101101",
A(375 downto 368) when "00101110",
A(383 downto 376) when "00101111",
A(391 downto 384) when "00110000",
A(399 downto 392) when "00110001",
A(407 downto 400) when "00110010",
A(415 downto 408) when "00110011",
A(423 downto 416) when "00110100",
A(431 downto 424) when "00110101",
A(439 downto 432) when "00110110",
A(447 downto 440) when "00110111",
A(455 downto 448) when "00111000",
A(463 downto 456) when "00111001",
A(471 downto 464) when "00111010",
A(479 downto 472) when "00111011",
A(487 downto 480) when "00111100",
A(495 downto 488) when "00111101",
A(503 downto 496) when "00111110",
A(511 downto 504) when "00111111",
A(519 downto 512) when "01000000",
A(527 downto 520) when "01000001",
A(535 downto 528) when "01000010",
A(543 downto 536) when "01000011",
A(551 downto 544) when "01000100",
A(559 downto 552) when "01000101",
A(567 downto 560) when "01000110",
A(575 downto 568) when "01000111",
A(583 downto 576) when "01001000",
A(591 downto 584) when "01001001",
A(599 downto 592) when "01001010",
A(607 downto 600) when "01001011",
A(615 downto 608) when "01001100",
A(623 downto 616) when "01001101",
A(631 downto 624) when "01001110",
A(639 downto 632) when "01001111",
A(647 downto 640) when "01010000",
A(655 downto 648) when "01010001",
A(663 downto 656) when "01010010",
A(671 downto 664) when "01010011",
A(679 downto 672) when "01010100",
A(687 downto 680) when "01010101",
A(695 downto 688) when "01010110",
A(703 downto 696) when "01010111",
A(711 downto 704) when "01011000",
A(719 downto 712) when "01011001",
A(727 downto 720) when "01011010",
A(735 downto 728) when "01011011",
A(743 downto 736) when "01011100",
A(751 downto 744) when "01011101",
A(759 downto 752) when "01011110",
A(767 downto 760) when "01011111",
A(775 downto 768) when "01100000",
A(783 downto 776) when "01100001",
A(791 downto 784) when "01100010",
A(799 downto 792) when "01100011",
A(807 downto 800) when "01100100",
A(815 downto 808) when "01100101",
A(823 downto 816) when "01100110",
A(831 downto 824) when "01100111",
A(839 downto 832) when "01101000",
A(847 downto 840) when "01101001",
A(855 downto 848) when "01101010",
A(863 downto 856) when "01101011",
A(871 downto 864) when "01101100",
A(879 downto 872) when "01101101",
A(887 downto 880) when "01101110",
A(895 downto 888) when "01101111",
A(903 downto 896) when "01110000",
A(911 downto 904) when "01110001",
A(919 downto 912) when "01110010",
A(927 downto 920) when "01110011",
A(935 downto 928) when "01110100",
A(943 downto 936) when "01110101",
A(951 downto 944) when "01110110",
A(959 downto 952) when "01110111",
A(967 downto 960) when "01111000",
A(975 downto 968) when "01111001",
A(983 downto 976) when "01111010",
A(991 downto 984) when "01111011",
A(999 downto 992) when "01111100",
A(1007 downto 1000) when "01111101",
A(1015 downto 1008) when "01111110",
A(1023 downto 1016) when "01111111",
A(1031 downto 1024) when "10000000",
A(1039 downto 1032) when "10000001",
A(1047 downto 1040) when "10000010",
A(1055 downto 1048) when "10000011",
A(1063 downto 1056) when "10000100",
A(1071 downto 1064) when "10000101",
A(1079 downto 1072) when "10000110",
A(1087 downto 1080) when "10000111",
A(1095 downto 1088) when "10001000",
A(1103 downto 1096) when "10001001",
A(1111 downto 1104) when "10001010",
A(1119 downto 1112) when "10001011",
A(1127 downto 1120) when "10001100",
A(1135 downto 1128) when "10001101",
A(1143 downto 1136) when "10001110",
A(1151 downto 1144) when "10001111",
A(1159 downto 1152) when "10010000",
A(1167 downto 1160) when "10010001",
A(1175 downto 1168) when "10010010",
A(1183 downto 1176) when "10010011",
A(1191 downto 1184) when "10010100",
A(1199 downto 1192) when "10010101",
A(1207 downto 1200) when "10010110",
A(1215 downto 1208) when "10010111",
A(1223 downto 1216) when "10011000",
A(1231 downto 1224) when "10011001",
A(1239 downto 1232) when "10011010",
A(1247 downto 1240) when "10011011",
A(1255 downto 1248) when "10011100",
A(1263 downto 1256) when "10011101",
A(1271 downto 1264) when "10011110",
A(1279 downto 1272) when "10011111",
A(1287 downto 1280) when "10100000",
A(1295 downto 1288) when "10100001",
A(1303 downto 1296) when "10100010",
A(1311 downto 1304) when "10100011",
A(1319 downto 1312) when "10100100",
A(1327 downto 1320) when "10100101",
A(1335 downto 1328) when "10100110",
A(1343 downto 1336) when "10100111",
A(1351 downto 1344) when "10101000",
A(1359 downto 1352) when "10101001",
A(1367 downto 1360) when "10101010",
A(1375 downto 1368) when "10101011",
A(1383 downto 1376) when "10101100",
A(1391 downto 1384) when "10101101",
A(1399 downto 1392) when "10101110",
A(1407 downto 1400) when "10101111",
A(1415 downto 1408) when "10110000",
A(1423 downto 1416) when "10110001",
A(1431 downto 1424) when "10110010",
A(1439 downto 1432) when "10110011",
A(1447 downto 1440) when "10110100",
A(1455 downto 1448) when "10110101",
A(1463 downto 1456) when "10110110",
A(1471 downto 1464) when "10110111",
A(1479 downto 1472) when "10111000",
A(1487 downto 1480) when "10111001",
A(1495 downto 1488) when "10111010",
A(1503 downto 1496) when "10111011",
A(1511 downto 1504) when "10111100",
A(1519 downto 1512) when "10111101",
A(1527 downto 1520) when "10111110",
A(1535 downto 1528) when "10111111",
A(1543 downto 1536) when "11000000",
A(1551 downto 1544) when "11000001",
A(1559 downto 1552) when "11000010",
A(1567 downto 1560) when "11000011",
A(1575 downto 1568) when "11000100",
A(1583 downto 1576) when "11000101",
A(1591 downto 1584) when "11000110",
A(1599 downto 1592) when "11000111",
A(1607 downto 1600) when "11001000",
A(1615 downto 1608) when "11001001",
A(1623 downto 1616) when "11001010",
A(1631 downto 1624) when "11001011",
A(1639 downto 1632) when "11001100",
A(1647 downto 1640) when "11001101",
A(1655 downto 1648) when "11001110",
A(1663 downto 1656) when "11001111",
A(1671 downto 1664) when "11010000",
A(1679 downto 1672) when "11010001",
A(1687 downto 1680) when "11010010",
A(1695 downto 1688) when "11010011",
A(1703 downto 1696) when "11010100",
A(1711 downto 1704) when "11010101",
A(1719 downto 1712) when "11010110",
A(1727 downto 1720) when "11010111",
A(1735 downto 1728) when "11011000",
A(1743 downto 1736) when "11011001",
A(1751 downto 1744) when "11011010",
A(1759 downto 1752) when "11011011",
A(1767 downto 1760) when "11011100",
A(1775 downto 1768) when "11011101",
A(1783 downto 1776) when "11011110",
A(1791 downto 1784) when "11011111",
A(1799 downto 1792) when "11100000",
A(1807 downto 1800) when "11100001",
A(1815 downto 1808) when "11100010",
A(1823 downto 1816) when "11100011",
A(1831 downto 1824) when "11100100",
A(1839 downto 1832) when "11100101",
A(1847 downto 1840) when "11100110",
A(1855 downto 1848) when "11100111",
A(1863 downto 1856) when "11101000",
A(1871 downto 1864) when "11101001",
A(1879 downto 1872) when "11101010",
A(1887 downto 1880) when "11101011",
A(1895 downto 1888) when "11101100",
A(1903 downto 1896) when "11101101",
A(1911 downto 1904) when "11101110",
A(1919 downto 1912) when "11101111",
A(1927 downto 1920) when "11110000",
A(1935 downto 1928) when "11110001",
A(1943 downto 1936) when "11110010",
A(1951 downto 1944) when "11110011",
A(1959 downto 1952) when "11110100",
A(1967 downto 1960) when "11110101",
A(1975 downto 1968) when "11110110",
A(1983 downto 1976) when "11110111",
A(1991 downto 1984) when "11111000",
A(1999 downto 1992) when "11111001",
A(2007 downto 2000) when "11111010",
A(2015 downto 2008) when "11111011",
A(2023 downto 2016) when "11111100",
A(2031 downto 2024) when "11111101",
A(2039 downto 2032) when "11111110",
A(2047 downto 2040) when "11111111",
"00000000"  when others;

end a;


