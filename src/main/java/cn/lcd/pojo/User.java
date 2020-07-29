package cn.lcd.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private int id;
    private String username;
    private String password;
    private String nickname;
    private String address;
    private int money;
    private int state;

    public User(int id, String username, String nickname, String address, int money, int state) {
        this.id = id;
        this.username = username;
        this.nickname = nickname;
        this.address = address;
        this.money = money;
        this.state = state;
    }
}
