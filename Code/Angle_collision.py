import pandas as pd
import matplotlib.pyplot as plt

csv_file_path = 'G:/data/Upper_and_Lower_prisms(30，45，60)_bearing_risk.csv'

df = pd.read_csv(csv_file_path, encoding='gbk')

plt.figure(figsize=(10, 6))

plt.plot(df['bearing'], df['bearing_risk(30)'], label='bearing_risk(30)', color='purple')
plt.plot(df['bearing'], df['bearing_risk(45)'], label='bearing_risk(45)', color='blue')
plt.plot(df['bearing'], df['bearing_risk(60)'], label='bearing_risk(60)', color='green')
plt.plot(df['bearing'], df['bearing_risk(HH)'], label='bearing_risk_density(HH)', color='red')


plt.xlabel('bearing', fontsize=14)
plt.ylabel('bearing risk', fontsize=14)
plt.ylim(0, 65)
plt.xlim(0, 90)
plt.legend(fontsize=12)
plt.tight_layout()

plt.show()