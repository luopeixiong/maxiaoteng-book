from matplotlib import pyplot as plt
from mysql_utils import MysqlHelper

def get_client(dbconfig={}):
    dbconfig = {
        'host': '127.0.0.1',
        "port": 3306,
        'user': 'root',
        'password': 'xx',
        'database': 'paypay',
        'charset': 'utf8mb4',
    }
    client = MysqlHelper(dbconfig)
    return client

def plot_demo():
    '''
    线形图显示
    paypay作为一个新增平台, 每周监控平台商品总数, 显示一下商品总数走势
    '''
    client = get_client()
    sql = 'select ts_short, sum(total_count) as count_sku from paypay.search_count group by ts_short;'
    res = client.query(sql)
    x_data = [r.get('ts_short') for r in res]
    y_data = [r.get('count_sku') for r in res]
    # x是日期, y是数量
    plt.plot(x_data, y_data, color='green', marker='o', linestyle='solid')

    # 添加标题
    plt.title('paypay sku volume trend')

    # y轴做标记
    plt.ylabel('-')

    plt.show()


if __name__ == "__main__":
    plot_demo()

