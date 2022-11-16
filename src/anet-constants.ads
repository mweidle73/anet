--
--  Copyright (C) 2011-2013 secunet Security Networks AG
--  Copyright (C) 2011-2016 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2011-2016 Adrian-Ken Rueegsegger <ken@codelabs.ch>
--
--  This program is free software; you can redistribute it and/or modify it
--  under the terms of the GNU General Public License as published by the
--  Free Software Foundation; either version 2 of the License, or (at your
--  option) any later version.  See <http://www.fsf.org/copyleft/gpl.txt>.
--
--  This program is distributed in the hope that it will be useful, but
--  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
--  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
--  for more details.
--
--  As a special exception, if other files instantiate generics from this
--  unit,  or  you  link  this  unit  with  other  files  to  produce  an
--  executable   this  unit  does  not  by  itself  cause  the  resulting
--  executable to  be  covered by the  GNU General  Public License.  This
--  exception does  not  however  invalidate  any  other reasons why  the
--  executable file might be covered by the GNU Public License.
--

pragma Warnings (Off);
with System.OS_Constants;
pragma Warnings (On);

package Anet.Constants is

   package Sys renames System.OS_Constants;

   --------------
   -- Families --
   --------------

   AF_UNIX           : constant := 1;        --  Unix domain family

   ------------------
   -- Socket modes --
   ------------------

   SOCK_RAW          : constant := 3;        --  Raw protocol interface

   ---------------------
   -- Protocol levels --
   ---------------------

   IPPROTO_IPV6      : constant := 41;       --  IPv6
   IPPROTO_ESP       : constant := 50;       --  ESP

   -----------------------
   -- Socket operations --
   -----------------------

   SO_PRIORITY       : constant := 12;       --  Socket priority for packets
   SO_BINDTODEVICE   : constant := 25;       --  Bind to interface device
   SO_ATTACH_FILTER  : constant := 26;       --  Socket filtering

   ---------------------
   -- Interface flags --
   ---------------------

   IFF_UP            : constant := 1;        --  Interface is up
   IFF_BROADCAST     : constant := 2;        --  Valid broadcast address set
   IFF_DEBUG         : constant := 4;        --  Internal debug flag
   IFF_LOOPBACK      : constant := 8;        --  Loopback device
   IFF_POINTOPOINT   : constant := 16;       --  Interface is p2p link
   IFF_NOTRAILERS    : constant := 32;       --  Avoid use of trailers
   IFF_RUNNING       : constant := 64;       --  Interface resources allocated
   IFF_NOARP         : constant := 128;      --  No address resolution
   IFF_PROMISC       : constant := 256;      --  Promiscuous mode
   IFF_ALLMULTI      : constant := 512;      --  Receive all multicast packets
   IFF_MASTER        : constant := 1024;     --  Master of load balancing
   IFF_SLAVE         : constant := 2048;     --  Slave of load balancing
   IFF_MULTICAST     : constant := 4096;     --  Multicast supported
   IFF_PORTSEL       : constant := 8192;     --  Can select media type (ifmap)
   IFF_AUTOMEDIA     : constant := 16384;    --  Auto media selection active
   IFF_DYNAMIC       : constant := 32768;    --  If down -> addresses lost

   ---------------------------
   -- Ethernet protocol IDs --
   ---------------------------

   ETH_P_ALL         : constant := 16#0003#; --  Every packet
   ETH_P_IP          : constant := 16#0800#; --  Internet Protocol packet
   ETH_P_ARP         : constant := 16#0806#; --  Address Resolution packet
   ETH_P_LLDP        : constant := 16#88CC#; --  Link Layer Discovery Protocol

   ---------------------
   -- Interface names --
   ---------------------

   IFNAMSIZ          : constant := 16;

end Anet.Constants;
