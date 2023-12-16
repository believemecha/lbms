class Student < User
    enum qualification: {
        ninth: 9,
        tenth: 10,
        eleventh: 11,
        twelfth: 12,
        adult: 13
    }
end