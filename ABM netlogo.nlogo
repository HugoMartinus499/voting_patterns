 turtles-own
[
  vote    ;; my vote (1-14)
  age-category
  trust
  credibility
]
patches-own[ non-usage ]

to setup
  clear-all
  set-default-shape turtles "person"
  ;set min-voting-age 16 ; Default minimum voting age
  ;set max-voting-age 100 ; Default maximum voting age

  create-turtles people [
    let age random (max-voting-age - min-voting-age + 1) + min-voting-age  ; Random age between min-voting-age and max-voting-age
    set vote determine-vote age ; Determine initial vote
    set age-category determine-age-category age
    set credibility random 10
    setxy random-xcor random-ycor
  ]
  ask turtles [ recolor ]

  ask n-of centers patches [
    set pcolor blue
    set non-usage 0
  ]

  ask n-of centers patches [
    set pcolor red
    set non-usage 0
  ]
  reset-ticks
end

;; move randomly
to move  ;; turtle procedure
  fd random 25
  ;; turn a random amount between -40 and 40 degrees,
  ;; keeping the average turn at 0
  rt random 50
  lt random 50
end

to-report determine-vote [age]
  let vote-value 0
  ifelse age < 18 [
    let random-probability random-float 100
    ifelse random-probability <= 7 [
      set vote-value 1 ; Enhedslisten
    ] [
      ifelse random-probability <= 12.6 [
        set vote-value 2 ; SF
      ] [
        ifelse random-probability <= 12.61 [
          set vote-value 3 ; Frie Grønne
        ] [
          ifelse random-probability <= 14.41 [
            set vote-value 4 ; Alternativet
          ] [
            ifelse random-probability <= 30.41 [
              set vote-value 5 ; Socialdemokraterne
            ] [
              ifelse random-probability <= 39.11 [
                set vote-value 6 ; Radikale
              ] [
                ifelse random-probability <= 43.81 [
                  set vote-value 7 ; Moderaterne
                ] [
                  ifelse random-probability <= 49.01 [
                    set vote-value 8 ; DF
                  ] [
                    ifelse random-probability <= 49.02 [
                      set vote-value 9 ; KD
                    ] [
                      ifelse random-probability <= 58.82 [
                        set vote-value 10 ; Venstre
                      ] [
                        ifelse random-probability <= 61.82 [
                          set vote-value 11 ; DD
                        ] [
                          ifelse random-probability <= 69.82 [
                            set vote-value 12 ; Konservative
                          ] [
                            ifelse random-probability <= 69.83 [
                              set vote-value 13 ; NB
                            ] [
                              set vote-value 14 ; LA
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ] [
    ifelse age >= 18 and age <= 65 [
      let random-probability random-float 100
      ifelse random-probability <= 5.13 [
        set vote-value 1
      ] [
        ifelse random-probability <= 13.43 [
          set vote-value 2
        ] [
          ifelse random-probability <= 14.33 [
            set vote-value 3
          ] [
            ifelse random-probability <= 17.66 [
              set vote-value 4
            ] [
              ifelse random-probability <= 45.16 [
                set vote-value 5
              ] [
                ifelse random-probability <= 48.95 [
                  set vote-value 6
                ] [
                  ifelse random-probability <= 58.22 [
                    set vote-value 7
                  ] [
                    ifelse random-probability <= 60.86 [
                      set vote-value 8
                    ] [
                      ifelse random-probability <= 61.38 [
                        set vote-value 9
                      ] [
                        ifelse random-probability <= 74.7 [
                          set vote-value 10
                        ] [
                          ifelse random-probability <= 82.82 [
                            set vote-value 11
                          ] [
                            ifelse random-probability <= 88.33 [
                              set vote-value 12
                            ] [
                              ifelse random-probability <= 92 [
                                set vote-value 13
                              ] [
                                set vote-value 14
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ] [
      let random-probability random-float 100
      ifelse random-probability <= 8 [
        set vote-value 1
      ] [
        ifelse random-probability <= 17.5 [
          set vote-value 2
        ] [
          ifelse random-probability <= 17.6 [
            set vote-value 3
          ] [
            ifelse random-probability <= 19.4 [
              set vote-value 4
            ] [
              ifelse random-probability <= 68.8 [
                set vote-value 5
              ] [
                ifelse random-probability <= 69.2 [
                  set vote-value 6
                ] [
                  ifelse random-probability <= 73.4 [
                    set vote-value 7
                  ] [
                    ifelse random-probability <= 77.2 [
                      set vote-value 8
                    ] [
                      ifelse random-probability <= 77.5 [
                        set vote-value 9
                      ] [
                        ifelse random-probability <= 85.6 [
                          set vote-value 10
                        ] [
                          ifelse random-probability <= 92.5 [
                            set vote-value 11
                          ] [
                            ifelse random-probability <= 96.6 [
                              set vote-value 12
                            ] [
                              ifelse random-probability <= 98.8 [
                                set vote-value 13
                              ] [
                                set vote-value 14
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ]
  report vote-value
end

to-report determine-age-category [age]
  let category 0
  if age < 20 [ set category 1]
  if age >= 20 and age < 65 [ set category 2]
  if age >= 65 [ set category 3]
  report category
end

to go
  ask turtles [ move ]
  ask turtles [
    if any? other turtles-here with [ credible] [
    ; Encountered another turtle, update trust
    set trust trust + 0.005
  ]
]

  ask turtles [
    if any? other turtles-here with [ uncredible] [
    ; Encountered another turtle, update trust
    set trust trust - 0.003
  ]
]
  ask turtles with [senior] [ ignore-enlightenment ]
  ask turtles with [adult] [ enlighten ]
  ask turtles with [young] [ enlighten2 ]
  ask turtles with [senior] [ ignore-persuade ]
  ask turtles with [adult] [ persuade ]
  ask turtles with [young] [ persuade2 ]

  ; place limits on the vote value
  ask turtles with [ vote > 14.5 ] [ set vote 14.5 ]   ;; setting max vote
  ask turtles with [ vote < 0.5 ] [ set vote 0.5 ]     ;; setting minimum vote

  ask turtles [ recolor ]

  ask patches with [ pcolor != black ] [ ;; we want non-used centers to disappear
    if not any? turtles-here [ set non-usage (non-usage + 1) ]
    if non-usage > non-usage-limit [ set pcolor black ]
  ]


  tick
end

to ignore-enlightenment
  if pcolor = blue [ set vote vote + 0.001 ]
  if pcolor = red [ set vote vote - 0.001 ]
  set non-usage 0
end

to enlighten
  if pcolor = blue [ set vote vote + 0.25 ]
  if pcolor = red [ set vote vote - 0.25 ]
  set non-usage 0
end

to enlighten2
  if pcolor = blue [ set vote vote + 0.35 ]
  if pcolor = red [ set vote vote - 0.35 ]
  set non-usage 0
end

to ignore-persuade
  ifelse Enhedslisten [
    if any? other turtles-here with [SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
      set vote vote + (0.0001 * trust)
    ]
  ] [
    ifelse SF [
      if any? other turtles-here with [Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
        set vote vote + (0.0001 * trust)
      ]
    ] [
      ifelse Frie-Grønne [
        if any? other turtles-here with [Alternativet or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
          set vote vote + (0.0001 * trust)
        ]
      ] [
        ifelse Alternativet [
          if any? other turtles-here with [Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
            set vote vote + (0.0001 * trust)
          ]
        ] [
          ifelse Socialdemokratiet [
            if any? other turtles-here with [Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
              set vote vote + (0.0001 * trust)
            ]
          ] [
            ifelse Radikale [
              if any? other turtles-here with [Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                set vote vote + (0.0001 * trust)
              ]
            ] [
              ifelse Moderaterne [
                if any? other turtles-here with [DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                  set vote vote + (0.0001 * trust)
                ]
              ] [
                ifelse DF [
                  if any? other turtles-here with [Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                    set vote vote + (0.0001 * trust)
                  ]
                ] [
                  ifelse Kristendemokraterne [
                    if any? other turtles-here with [Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                      set vote vote + (0.0001 * trust)
                    ]
                  ] [
                    ifelse Venstre [
                      if any? other turtles-here with [Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                        set vote vote + (0.0001 * trust)
                      ]
                    ] [
                      ifelse Danmarksdemokraterne [
                        if any? other turtles-here with [Konservative or Nye-Borgerlige or LA] [
                          set vote vote + (0.0001 * trust)
                        ]
                      ] [
                        ifelse Konservative [
                          if any? other turtles-here with [Nye-Borgerlige or LA] [
                            set vote vote + (0.0001 * trust)
                          ]
                        ] [
                          ifelse Nye-Borgerlige [
                            if any? other turtles-here with [LA] [
                              set vote vote + (0.0001 * trust)
                            ]
                          ] [
                            if any? other turtles-here with [LA] [
                              set vote vote
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ]
    ifelse LA [
      if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige] [
        set vote vote - (0.0001 * trust)
      ]
    ] [
      ifelse Nye-Borgerlige [
        if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative] [
          set vote vote - (0.0001 * trust)
        ]
      ] [
        ifelse Konservative [
          if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne] [
            set vote vote - (0.0001 * trust)
          ]
        ] [
          ifelse Danmarksdemokraterne [
            if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre] [
              set vote vote - (0.0001 * trust)
            ]
          ] [
            ifelse Venstre [
              if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne] [
                set vote vote - (0.0001 * trust)
              ]
            ] [
              ifelse Kristendemokraterne [
                if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF] [
                  set vote vote - (0.0001 * trust)
                ]
              ] [
                ifelse DF [
                  if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne] [
                    set vote vote - (0.0001 * trust)
                  ]
                ] [
                  ifelse Moderaterne [
                    if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale] [
                      set vote vote - (0.0001 * trust)
                    ]
                  ] [
                    ifelse Radikale [
                      if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet] [
                        set vote vote - (0.0001 * trust)
                      ]
                    ] [
                      ifelse Socialdemokratiet [
                        if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne] [
                          set vote vote - (0.0001 * trust)
                        ]
                      ] [
                        ifelse Frie-Grønne [
                          if any? other turtles-here with [Enhedslisten or SF or Alternativet] [
                            set vote vote - (0.0001 * trust)
                          ]
                        ] [
                          ifelse Alternativet [
                            if any? other turtles-here with [Enhedslisten or SF] [
                              set vote vote - (0.0001 * trust)
                            ]
                          ] [
                            ifelse SF [
                              if any? other turtles-here with [Enhedslisten] [
                                set vote vote - (0.0001 * trust)
                              ]
                            ] [
                              if any? other turtles-here with [Enhedslisten] [
                                set vote vote
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
end

to persuade
  ifelse Enhedslisten [
    if any? other turtles-here with [SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
      set vote vote + (0.01 * trust)
    ]
  ] [
    ifelse SF [
      if any? other turtles-here with [Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
        set vote vote + (0.01 * trust)
      ]
    ] [
      ifelse Frie-Grønne [
        if any? other turtles-here with [Alternativet or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
          set vote vote + (0.01 * trust)
        ]
      ] [
        ifelse Alternativet [
          if any? other turtles-here with [Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
            set vote vote + (0.01 * trust)
          ]
        ] [
          ifelse Socialdemokratiet [
            if any? other turtles-here with [Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
              set vote vote + (0.01 * trust)
            ]
          ] [
            ifelse Radikale [
              if any? other turtles-here with [Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                set vote vote + (0.01 * trust)
              ]
            ] [
              ifelse Moderaterne [
                if any? other turtles-here with [DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                  set vote vote + (0.01 * trust)
                ]
              ] [
                ifelse DF [
                  if any? other turtles-here with [Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                    set vote vote + (0.01 * trust)
                  ]
                ] [
                  ifelse Kristendemokraterne [
                    if any? other turtles-here with [Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                      set vote vote + (0.01 * trust)
                    ]
                  ] [
                    ifelse Venstre [
                      if any? other turtles-here with [Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                        set vote vote + (0.01 * trust)
                      ]
                    ] [
                      ifelse Danmarksdemokraterne [
                        if any? other turtles-here with [Konservative or Nye-Borgerlige or LA] [
                          set vote vote + (0.01 * trust)
                        ]
                      ] [
                        ifelse Konservative [
                          if any? other turtles-here with [Nye-Borgerlige or LA] [
                            set vote vote + (0.01 * trust)
                          ]
                        ] [
                          ifelse Nye-Borgerlige [
                            if any? other turtles-here with [LA] [
                              set vote vote + (0.01 * trust)
                            ]
                          ] [
                            if any? other turtles-here with [LA] [
                              set vote vote
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ]
    ifelse LA [
      if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige] [
        set vote vote - (0.01 * trust)
      ]
    ] [
      ifelse Nye-Borgerlige [
        if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative] [
          set vote vote - (0.01 * trust)
        ]
      ] [
        ifelse Konservative [
          if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne] [
            set vote vote - (0.01 * trust)
          ]
        ] [
          ifelse Danmarksdemokraterne [
            if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre] [
              set vote vote - (0.01 * trust)
            ]
          ] [
            ifelse Venstre [
              if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne] [
                set vote vote - (0.01 * trust)
              ]
            ] [
              ifelse Kristendemokraterne [
                if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF] [
                  set vote vote - (0.01 * trust)
                ]
              ] [
                ifelse DF [
                  if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne] [
                    set vote vote - (0.01 * trust)
                  ]
                ] [
                  ifelse Moderaterne [
                    if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale] [
                      set vote vote - (0.01 * trust)
                    ]
                  ] [
                    ifelse Radikale [
                      if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet] [
                        set vote vote - (0.01 * trust)
                      ]
                    ] [
                      ifelse Socialdemokratiet [
                        if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne] [
                          set vote vote - (0.01 * trust)
                        ]
                      ] [
                        ifelse Frie-Grønne [
                          if any? other turtles-here with [Enhedslisten or SF or Alternativet] [
                            set vote vote - (0.01 * trust)
                          ]
                        ] [
                          ifelse Alternativet [
                            if any? other turtles-here with [Enhedslisten or SF] [
                              set vote vote - (0.01 * trust)
                            ]
                          ] [
                            ifelse SF [
                              if any? other turtles-here with [Enhedslisten] [
                                set vote vote - (0.01 * trust)
                              ]
                            ] [
                              if any? other turtles-here with [Enhedslisten] [
                                set vote vote
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
end

to persuade2
  ifelse Enhedslisten [
    if any? other turtles-here with [SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
      set vote vote + (0.015 * trust)
    ]
  ] [
    ifelse SF [
      if any? other turtles-here with [Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
        set vote vote + (0.015 * trust)
      ]
    ] [
      ifelse Frie-Grønne [
        if any? other turtles-here with [Alternativet or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
          set vote vote + (0.015 * trust)
        ]
      ] [
        ifelse Alternativet [
          if any? other turtles-here with [Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
            set vote vote + (0.015 * trust)
          ]
        ] [
          ifelse Socialdemokratiet [
            if any? other turtles-here with [Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
              set vote vote + (0.015 * trust)
            ]
          ] [
            ifelse Radikale [
              if any? other turtles-here with [Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                set vote vote + (0.015 * trust)
              ]
            ] [
              ifelse Moderaterne [
                if any? other turtles-here with [DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                  set vote vote + (0.015 * trust)
                ]
              ] [
                ifelse DF [
                  if any? other turtles-here with [Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                    set vote vote + (0.015 * trust)
                  ]
                ] [
                  ifelse Kristendemokraterne [
                    if any? other turtles-here with [Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                      set vote vote + (0.015 * trust)
                    ]
                  ] [
                    ifelse Venstre [
                      if any? other turtles-here with [Danmarksdemokraterne or Konservative or Nye-Borgerlige or LA] [
                        set vote vote + (0.015 * trust)
                      ]
                    ] [
                      ifelse Danmarksdemokraterne [
                        if any? other turtles-here with [Konservative or Nye-Borgerlige or LA] [
                          set vote vote + (0.015 * trust)
                        ]
                      ] [
                        ifelse Konservative [
                          if any? other turtles-here with [Nye-Borgerlige or LA] [
                            set vote vote + (0.015 * trust)
                          ]
                        ] [
                          ifelse Nye-Borgerlige [
                            if any? other turtles-here with [LA] [
                              set vote vote + (0.015 * trust)
                            ]
                          ] [
                            if any? other turtles-here with [LA] [
                              set vote vote
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ]
    ifelse LA [
      if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative or Nye-Borgerlige] [
        set vote vote - (0.015 * trust)
      ]
    ] [
      ifelse Nye-Borgerlige [
        if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne or Konservative] [
          set vote vote - (0.015 * trust)
        ]
      ] [
        ifelse Konservative [
          if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre or Danmarksdemokraterne] [
            set vote vote - (0.015 * trust)
          ]
        ] [
          ifelse Danmarksdemokraterne [
            if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne or Venstre] [
              set vote vote - (0.015 * trust)
            ]
          ] [
            ifelse Venstre [
              if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF or Kristendemokraterne] [
                set vote vote - (0.015 * trust)
              ]
            ] [
              ifelse Kristendemokraterne [
                if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne or DF] [
                  set vote vote - (0.015 * trust)
                ]
              ] [
                ifelse DF [
                  if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale or Moderaterne] [
                    set vote vote - (0.015 * trust)
                  ]
                ] [
                  ifelse Moderaterne [
                    if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet or Radikale] [
                      set vote vote - (0.015 * trust)
                    ]
                  ] [
                    ifelse Radikale [
                      if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne or Socialdemokratiet] [
                        set vote vote - (0.015 * trust)
                      ]
                    ] [
                      ifelse Socialdemokratiet [
                        if any? other turtles-here with [Enhedslisten or SF or Alternativet or Frie-Grønne] [
                          set vote vote - (0.015 * trust)
                        ]
                      ] [
                        ifelse Frie-Grønne [
                          if any? other turtles-here with [Enhedslisten or SF or Alternativet] [
                            set vote vote - (0.015 * trust)
                          ]
                        ] [
                          ifelse Alternativet [
                            if any? other turtles-here with [Enhedslisten or SF] [
                              set vote vote - (0.015 * trust)
                            ]
                          ] [
                            ifelse SF [
                              if any? other turtles-here with [Enhedslisten] [
                                set vote vote - (0.015 * trust)
                              ]
                            ] [
                              if any? other turtles-here with [Enhedslisten] [
                                set vote vote
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
end

to-report senior
  report age-category = 3
end

to-report adult
  report age-category = 2
end

to-report young
  report age-category = 1
end

to-report credible
  report credibility > 7
end

to-report uncredible
  report credibility < 4
end

to recolor  ;; turtle procedure
  ;; Assign different colors based on the value of the vote variable
  if vote >= 0.5 and vote < 1.5 [ set color red ]
  if vote >= 1.5 and vote < 2.5 [ set color orange ]
  if vote >= 2.5 and vote < 3.5 [ set color yellow ]
  if vote >= 3.5 and vote < 4.5 [ set color green ]
  if vote >= 4.5 and vote < 5.5 [ set color cyan ]
  if vote >= 5.5 and vote < 6.5 [ set color sky ]
  if vote >= 6.5 and vote < 7.5 [ set color blue ]
  if vote >= 7.5 and vote < 8.5 [ set color violet ]
  if vote >= 8.5 and vote < 9.5 [ set color magenta ]
  if vote >= 9.5 and vote < 10.5 [ set color brown ]
  if vote >= 10.5 and vote < 11.5 [ set color black ]
  if vote >= 11.5 and vote < 12.5 [ set color gray ]
  if vote >= 12.5 and vote < 13.5 [ set color white ]
  if vote >= 13.5 and vote < 14.5 [ set color pink ]
end

to-report right-leaning
  report vote >= 10.5
end

to-report center-right
  report vote >= 6.5 and vote < 10.5
end

to-report center-left
  report vote >= 4.5 and vote < 6.5
end

to-report left-leaning
  report vote >= 0.5 and vote < 4.5
end

to-report Enhedslisten
  report vote >= 0.5 and vote < 1.5
end

to-report SF
  report vote >= 1.5 and vote < 2.5
end

to-report Frie-Grønne
  report vote >= 2.5 and vote < 3.5
end

to-report Alternativet
  report vote >= 3.5 and vote < 4.5
end

to-report Socialdemokratiet
  report vote >= 4.5 and vote < 5.5
end

to-report Radikale
  report vote >= 5.5 and vote < 6.5
end

to-report Moderaterne
  report vote >= 6.5 and vote < 7.5
end

to-report DF
  report vote >= 7.5 and vote < 8.5
end

to-report Kristendemokraterne
  report vote >= 8.5 and vote < 9.5
end

to-report Venstre
  report vote >= 9.5 and vote < 10.5
end

to-report Danmarksdemokraterne
  report vote >= 10.5 and vote < 11.5
end

to-report Konservative
  report vote >= 11.5 and vote < 12.5
end

to-report Nye-Borgerlige
  report vote >= 12.5 and vote < 13.5
end

to-report LA
  report vote >= 13.5 and vote < 14.5
end

to set-min-voting-age [new-age]
  set min-voting-age new-age
  ask turtles [
    set vote determine-vote new-age
    recolor
  ]
end

to set-max-voting-age [new-age]
  set max-voting-age new-age
  ask turtles [
    set vote determine-vote new-age
    recolor
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
243
76
778
612
-1
-1
15.97
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
106
30
169
63
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

BUTTON
30
29
93
62
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
29
115
201
148
min-voting-age
min-voting-age
0
100
16.0
1
1
NIL
HORIZONTAL

SLIDER
29
75
201
108
max-voting-age
max-voting-age
0
100
80.0
1
1
NIL
HORIZONTAL

SLIDER
242
28
414
61
people
people
0
500
100.0
10
1
NIL
HORIZONTAL

SLIDER
429
28
601
61
centers
centers
0
100
50.0
1
1
NIL
HORIZONTAL

SLIDER
29
159
201
192
non-usage-limit
non-usage-limit
0
100
100.0
1
1
NIL
HORIZONTAL

PLOT
801
29
2537
263
Number of each political viewpoint
Time
Count
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Left-leaning" 1.0 0 -5298144 true "" "plot count turtles with [ left-leaning ]"
"Center-left" 1.0 0 -1604481 true "" "plot count turtles with [ center-left ]"
"Center-right" 1.0 0 -8275240 true "" "plot count turtles with [ center-right ]"
"Right-leaning" 1.0 0 -14454117 true "" "plot count turtles with [ right-leaning ]"

MONITOR
801
263
898
308
Left Leaning
count turtles with [left-leaning]
1
1
11

MONITOR
896
263
987
308
Center-left
count turtles with [center-left]
1
1
11

MONITOR
987
263
1083
308
Center-right
count turtles with [center-right]
1
1
11

MONITOR
1083
263
1194
308
Right Leaning
count turtles with [right-leaning]
1
1
11

PLOT
801
319
2532
587
Number of each party
Time
Count
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Enhedslisten" 1.0 0 -2674135 true "" "plot count turtles with [Enhedslisten]"
"SF" 1.0 0 -955883 true "" "plot count turtles with [SF]"
"Frie Grønne" 1.0 0 -1184463 true "" "plot count turtles with [Frie-Grønne]"
"Alternativet" 1.0 0 -10899396 true "" "plot count turtles with [Alternativet]"
"Socialdemokratiet" 1.0 0 -11221820 true "" "plot count turtles with [Socialdemokratiet]"
"Radikale" 1.0 0 -13791810 true "" "plot count turtles with [Radikale]"
"Moderaterne" 1.0 0 -13345367 true "" "plot count turtles with [Moderaterne]"
"DF" 1.0 0 -8630108 true "" "plot count turtles with [DF]"
"Kristendemokraterne" 1.0 0 -5825686 true "" "plot count turtles with [Kristendemokraterne]"
"Venstre" 1.0 0 -6459832 true "" "plot count turtles with [Venstre]"
"Danmarksdemokraterne" 1.0 0 -16777216 true "" "plot count turtles with [Danmarksdemokraterne]"
"Konservative" 1.0 0 -7500403 true "" "plot count turtles with [Konservative]"
"Nye Borgerlige" 1.0 0 -1 true "" "plot count turtles with [Nye-Borgerlige]"
"Liberal Alliance" 1.0 0 -2064490 true "" "plot count turtles with [LA]"

MONITOR
801
587
877
632
Enhedslisten
count turtles with [Enhedslisten]
2
1
11

MONITOR
877
587
945
632
SF
count turtles with [SF]
2
1
11

MONITOR
943
587
1017
632
Frie Grønne
count turtles with [Frie-Grønne]
2
1
11

MONITOR
1015
587
1087
632
Alternativet
count turtles with [Alternativet]
2
1
11

MONITOR
1085
587
1193
632
Socialdemokratiet
count turtles with [Socialdemokratiet]
2
1
11

MONITOR
1192
587
1254
632
Radikale
count turtles with [Radikale]
2
1
11

MONITOR
1252
587
1336
632
Moderaterne
count turtles with [Moderaterne]
2
1
11

MONITOR
1334
587
1391
632
DF
count turtles with [DF]
2
1
11

MONITOR
1388
587
1520
632
Kristendemokraterne
count turtles with [Kristendemokraterne]
2
1
11

MONITOR
1519
587
1584
632
Venstre
count turtles with [Venstre]
2
1
11

MONITOR
1583
587
1727
632
Danmarksdemokraterne
count turtles with [Danmarksdemokraterne]
2
1
11

MONITOR
1725
587
1801
632
Konservative
count turtles with [Konservative]
2
1
11

MONITOR
1799
587
1883
632
Nye Borgerlige
count turtles with [Nye-Borgerlige]
2
1
11

MONITOR
1881
587
1975
632
Liberal Alliance
count turtles with [LA]
2
1
11

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
1.0
    org.nlogo.sdm.gui.AggregateDrawing 1
        org.nlogo.sdm.gui.ReservoirFigure "attributes" "attributes" 1 "FillColor" "Color" 192 192 192 179 37 30 30
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
