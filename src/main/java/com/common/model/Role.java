package com.common.model;

import java.util.HashMap;
import java.util.Map;

public class Role {

    static public enum ROLE{
        administrator,
        manager,
        member,
        guest
    }

    ROLE role = ROLE.guest;

    static public Map<ROLE, Integer> levels = new HashMap<ROLE, Integer>();

    static{
        levels.put(ROLE.administrator, 90);
        levels.put(ROLE.manager, 80);
        levels.put(ROLE.member, 70);
        levels.put(ROLE.guest, 0);
    }
}
